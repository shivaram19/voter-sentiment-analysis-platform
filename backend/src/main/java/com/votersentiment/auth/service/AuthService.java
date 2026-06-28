package com.votersentiment.auth.service;

import com.votersentiment.auth.RefreshToken;
import com.votersentiment.auth.RefreshTokenRepository;
import com.votersentiment.auth.dto.*;
import com.votersentiment.user.Role;
import com.votersentiment.user.User;
import com.votersentiment.user.UserRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.BadRequestException;
import jakarta.ws.rs.NotAuthorizedException;
import org.mindrot.jbcrypt.BCrypt;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.UUID;

@ApplicationScoped
public class AuthService {

    @Inject
    UserRepository userRepository;

    @Inject
    RefreshTokenRepository refreshTokenRepository;

    @Inject
    JwtService jwtService;

    private static final long REFRESH_TOKEN_DAYS = 7;

    @Transactional
    public LoginResponse login(LoginRequest request) {
        User user = userRepository.findByUsername(request.getUsername())
                .orElseThrow(() -> new NotAuthorizedException("Invalid credentials"));
        if (!user.isActive() || user.getDeletedAt() != null) {
            throw new NotAuthorizedException("Invalid credentials");
        }
        if (!BCrypt.checkpw(request.getPassword(), user.getPasswordHash())) {
            throw new NotAuthorizedException("Invalid credentials");
        }
        return createTokenResponse(user);
    }

    @Transactional
    public LoginResponse refresh(RefreshRequest request) {
        String hash = jwtService.hashToken(request.getRefreshToken());
        RefreshToken token = refreshTokenRepository.findByHash(hash)
                .orElseThrow(() -> new NotAuthorizedException("Invalid refresh token"));

        if (token.isReused() || token.isRevoked() || token.getExpiresAt().isBefore(Instant.now())) {
            refreshTokenRepository.revokeFamily(token.getFamily());
            throw new NotAuthorizedException("Token reuse detected");
        }

        User user = token.getUser();
        if (!user.isActive() || user.getDeletedAt() != null) {
            refreshTokenRepository.revokeFamily(token.getFamily());
            throw new NotAuthorizedException("Invalid credentials");
        }

        // Rotate: revoke the current refresh token and issue a new one in the same family.
        token.setRevoked(true);
        refreshTokenRepository.persist(token);

        return createTokenResponse(user, token.getFamily());
    }

    @Transactional
    public User register(RegisterRequest request) {
        if (userRepository.existsByUsername(request.getUsername())) {
            throw new BadRequestException("Username already exists");
        }
        User user = User.builder()
                .username(request.getUsername())
                .passwordHash(BCrypt.hashpw(request.getPassword(), BCrypt.gensalt(12)))
                .name(request.getName())
                .email(request.getEmail())
                .phone(request.getPhone())
                .assignedRegion(request.getAssignedRegion())
                .role(request.getRole())
                .isActive(true)
                .build();
        userRepository.persist(user);
        return user;
    }

    public UserProfileDto me(User user) {
        return UserProfileDto.builder()
                .id(user.getId())
                .username(user.getUsername())
                .name(user.getName())
                .email(user.getEmail())
                .phone(user.getPhone())
                .role(user.getRole())
                .assignedRegion(user.getAssignedRegion())
                .isActive(user.isActive())
                .build();
    }

    private LoginResponse createTokenResponse(User user) {
        return createTokenResponse(user, UUID.randomUUID().toString());
    }

    private LoginResponse createTokenResponse(User user, String family) {
        String accessToken = jwtService.generateAccessToken(user);
        String rawRefresh = jwtService.generateRefreshTokenValue();
        String refreshHash = jwtService.hashToken(rawRefresh);

        RefreshToken refreshToken = RefreshToken.builder()
                .tokenHash(refreshHash)
                .user(user)
                .family(family)
                .expiresAt(Instant.now().plus(REFRESH_TOKEN_DAYS, ChronoUnit.DAYS))
                .revoked(false)
                .reused(false)
                .build();
        refreshTokenRepository.persist(refreshToken);

        return LoginResponse.builder()
                .accessToken(accessToken)
                .refreshToken(rawRefresh)
                .tokenType("Bearer")
                .expiresIn(jwtService.accessTokenLifespanSeconds)
                .username(user.getUsername())
                .role(user.getRole().name())
                .build();
    }
}

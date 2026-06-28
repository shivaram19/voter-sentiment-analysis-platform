package com.votersentiment.auth;

import io.smallrye.common.annotation.Blocking;

import com.votersentiment.auth.dto.*;
import com.votersentiment.auth.service.AuthService;
import com.votersentiment.common.ApiResponse;
import com.votersentiment.user.User;
import com.votersentiment.user.UserRepository;
import jakarta.annotation.security.PermitAll;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.SecurityContext;

@Blocking
@Path("/auth")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class AuthResource {

    @Inject
    AuthService authService;

    @Inject
    UserRepository userRepository;

    @POST
    @Path("/login")
    @PermitAll
    public ApiResponse<LoginResponse> login(@Valid LoginRequest request) {
        return ApiResponse.ok(authService.login(request));
    }

    @POST
    @Path("/register")
    @RolesAllowed("ADMIN")
    public ApiResponse<UserProfileDto> register(@Valid RegisterRequest request) {
        User user = authService.register(request);
        return ApiResponse.ok(authService.me(user), "User registered successfully");
    }

    @POST
    @Path("/refresh")
    @PermitAll
    public ApiResponse<LoginResponse> refresh(@Valid RefreshRequest request) {
        return ApiResponse.ok(authService.refresh(request));
    }

    @GET
    @Path("/me")
    @RolesAllowed({"ADMIN", "SUPERVISOR", "SURVEYOR"})
    public ApiResponse<UserProfileDto> me(@Context SecurityContext securityContext) {
        String username = securityContext.getUserPrincipal().getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new NotAuthorizedException("User not found"));
        return ApiResponse.ok(authService.me(user));
    }
}

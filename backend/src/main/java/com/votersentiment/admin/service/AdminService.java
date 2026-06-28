package com.votersentiment.admin.service;

import com.votersentiment.admin.dto.DashboardStatsDto;
import com.votersentiment.admin.dto.UserDto;
import com.votersentiment.admin.dto.UserRequestDto;
import com.votersentiment.questionnaire.repo.QuestionnaireRepository;
import com.votersentiment.survey.SyncStatus;
import com.votersentiment.survey.repo.SurveyRepository;
import com.votersentiment.user.Role;
import com.votersentiment.user.User;
import com.votersentiment.user.UserRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.BadRequestException;
import jakarta.ws.rs.NotFoundException;
import org.mindrot.jbcrypt.BCrypt;

import java.time.Instant;
import java.util.UUID;

@ApplicationScoped
public class AdminService {

    @Inject
    QuestionnaireRepository questionnaireRepository;

    @Inject
    SurveyRepository surveyRepository;

    @Inject
    UserRepository userRepository;

    public DashboardStatsDto dashboardStats() {
        return DashboardStatsDto.builder()
                .totalQuestionnaires(questionnaireRepository.countActive())
                .activeQuestionnaires(questionnaireRepository.count("isActive = true and deletedAt is null"))
                .totalSurveyors(userRepository.count("role = ?1 and deletedAt is null", Role.SURVEYOR))
                .totalSurveys(surveyRepository.count())
                .pendingSurveys(surveyRepository.countBySyncStatus(SyncStatus.PENDING))
                .syncedSurveys(surveyRepository.countBySyncStatus(SyncStatus.SYNCED))
                .failedSurveys(surveyRepository.countBySyncStatus(SyncStatus.FAILED))
                .build();
    }

    @Transactional
    public UserDto createUser(UserRequestDto dto) {
        if (userRepository.existsByUsername(dto.getUsername())) {
            throw new BadRequestException("Username already exists");
        }
        User user = User.builder()
                .username(dto.getUsername())
                .passwordHash(dto.getPassword() != null ? BCrypt.hashpw(dto.getPassword(), BCrypt.gensalt(12)) : "")
                .name(dto.getName())
                .email(dto.getEmail())
                .phone(dto.getPhone())
                .assignedRegion(dto.getAssignedRegion())
                .role(dto.getRole())
                .isActive(dto.isActive())
                .build();
        userRepository.persist(user);
        return toDto(user);
    }

    @Transactional
    public UserDto updateUser(UUID id, UserRequestDto dto) {
        User user = userRepository.findActiveById(id)
                .orElseThrow(() -> new NotFoundException("User not found"));
        user.setName(dto.getName());
        user.setEmail(dto.getEmail());
        user.setPhone(dto.getPhone());
        user.setAssignedRegion(dto.getAssignedRegion());
        user.setRole(dto.getRole());
        user.setActive(dto.isActive());
        if (dto.getPassword() != null && !dto.getPassword().isBlank()) {
            user.setPasswordHash(BCrypt.hashpw(dto.getPassword(), BCrypt.gensalt(12)));
        }
        return toDto(user);
    }

    @Transactional
    public void deleteUser(UUID id) {
        User user = userRepository.findActiveById(id)
                .orElseThrow(() -> new NotFoundException("User not found"));
        user.setDeletedAt(Instant.now());
    }

    public UserDto getUser(UUID id) {
        User user = userRepository.findActiveById(id)
                .orElseThrow(() -> new NotFoundException("User not found"));
        return toDto(user);
    }

    private UserDto toDto(User user) {
        return UserDto.builder()
                .id(user.getId())
                .username(user.getUsername())
                .name(user.getName())
                .email(user.getEmail())
                .phone(user.getPhone())
                .role(user.getRole())
                .assignedRegion(user.getAssignedRegion())
                .isActive(user.isActive())
                .createdAt(user.getCreatedAt())
                .updatedAt(user.getUpdatedAt())
                .build();
    }
}

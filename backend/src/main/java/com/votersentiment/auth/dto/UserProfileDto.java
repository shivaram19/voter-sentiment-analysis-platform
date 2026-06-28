package com.votersentiment.auth.dto;

import com.votersentiment.user.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserProfileDto {

    private UUID id;
    private String username;
    private String name;
    private String email;
    private String phone;
    private Role role;
    private String assignedRegion;
    private boolean isActive;
}

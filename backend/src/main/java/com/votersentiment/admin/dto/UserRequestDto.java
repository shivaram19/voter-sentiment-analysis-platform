package com.votersentiment.admin.dto;

import com.votersentiment.user.Role;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class UserRequestDto {

    @NotBlank(message = "Username is required")
    private String username;

    private String password;

    @NotBlank(message = "Name is required")
    private String name;

    @Email(message = "Invalid email")
    private String email;

    private String phone;

    private String assignedRegion;

    @NotNull(message = "Role is required")
    private Role role;

    private boolean isActive;
}

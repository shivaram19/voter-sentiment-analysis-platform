package com.votersentiment.admin;

import io.smallrye.common.annotation.Blocking;

import com.votersentiment.admin.dto.UserDto;
import com.votersentiment.admin.dto.UserRequestDto;
import com.votersentiment.admin.service.AdminService;
import com.votersentiment.common.ApiResponse;
import com.votersentiment.common.PagedResponse;
import com.votersentiment.user.User;
import com.votersentiment.user.UserRepository;
import io.quarkus.panache.common.Page;
import io.quarkus.panache.common.Sort;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Blocking
@Path("/admin/users")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UserResource {

    @Inject
    AdminService adminService;

    @Inject
    UserRepository userRepository;

    @GET
    @RolesAllowed({"ADMIN", "SUPERVISOR"})
    public ApiResponse<PagedResponse<UserDto>> list(@QueryParam("page") @DefaultValue("0") int page,
                                                    @QueryParam("size") @DefaultValue("20") int size) {
        long total = userRepository.countActive();
        List<User> users = userRepository.listActive(page, size, "name");
        List<UserDto> dtos = users.stream()
                .map(this::toDto)
                .collect(Collectors.toList());
        return ApiResponse.ok(PagedResponse.of(dtos, page, size, total));
    }

    @POST
    @RolesAllowed("ADMIN")
    public ApiResponse<UserDto> create(@Valid UserRequestDto dto) {
        return ApiResponse.ok(adminService.createUser(dto));
    }

    @GET
    @Path("/{id}")
    @RolesAllowed({"ADMIN", "SUPERVISOR"})
    public ApiResponse<UserDto> get(@PathParam("id") UUID id) {
        return ApiResponse.ok(adminService.getUser(id));
    }

    @PUT
    @Path("/{id}")
    @RolesAllowed("ADMIN")
    public ApiResponse<UserDto> update(@PathParam("id") UUID id, @Valid UserRequestDto dto) {
        return ApiResponse.ok(adminService.updateUser(id, dto));
    }

    @DELETE
    @Path("/{id}")
    @RolesAllowed("ADMIN")
    public ApiResponse<Void> delete(@PathParam("id") UUID id) {
        adminService.deleteUser(id);
        return ApiResponse.ok(null, "User deleted");
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

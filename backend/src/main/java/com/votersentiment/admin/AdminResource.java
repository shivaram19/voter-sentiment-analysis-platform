package com.votersentiment.admin;

import io.smallrye.common.annotation.Blocking;

import com.votersentiment.admin.dto.DashboardStatsDto;
import com.votersentiment.admin.service.AdminService;
import com.votersentiment.common.ApiResponse;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Blocking
@Path("/admin/dashboard")
@Produces(MediaType.APPLICATION_JSON)
public class AdminResource {

    @Inject
    AdminService adminService;

    @GET
    @Path("/stats")
    @RolesAllowed({"ADMIN", "SUPERVISOR"})
    public ApiResponse<DashboardStatsDto> stats() {
        return ApiResponse.ok(adminService.dashboardStats());
    }
}

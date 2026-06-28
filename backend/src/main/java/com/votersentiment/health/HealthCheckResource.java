package com.votersentiment.health;

import io.smallrye.common.annotation.Blocking;

import com.votersentiment.common.ApiResponse;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import java.time.Instant;
import java.util.Map;

@Blocking
@Path("/health")
@Produces(MediaType.APPLICATION_JSON)
public class HealthCheckResource {

    @GET
    public ApiResponse<Map<String, Object>> health() {
        return ApiResponse.ok(Map.of("status", "UP", "time", Instant.now().toString()));
    }

    @GET
    @Path("/live")
    public ApiResponse<Map<String, Object>> live() {
        return ApiResponse.ok(Map.of("status", "UP"));
    }

    @GET
    @Path("/ready")
    public ApiResponse<Map<String, Object>> ready() {
        // TODO: verify datasource and redis connectivity for a true readiness check
        return ApiResponse.ok(Map.of("status", "UP"));
    }
}

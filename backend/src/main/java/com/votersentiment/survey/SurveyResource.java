package com.votersentiment.survey;

import io.smallrye.common.annotation.Blocking;

import com.votersentiment.common.ApiResponse;
import com.votersentiment.survey.dto.*;
import com.votersentiment.survey.service.SurveyService;
import com.votersentiment.user.User;
import com.votersentiment.user.UserRepository;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.SecurityContext;

import java.util.List;
import java.util.UUID;

@Blocking
@Path("/survey")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class SurveyResource {

    @Inject
    SurveyService surveyService;

    @Inject
    UserRepository userRepository;

    @POST
    @Path("/start")
    @RolesAllowed({"SURVEYOR", "ADMIN", "SUPERVISOR"})
    public ApiResponse<SurveyDto> start(@Valid StartSurveyRequest request, @Context SecurityContext sc) {
        UUID surveyorId = resolveUserId(sc);
        return ApiResponse.ok(surveyService.startSurvey(surveyorId, request));
    }

    @POST
    @Path("/{id}/response")
    @RolesAllowed({"SURVEYOR", "ADMIN", "SUPERVISOR"})
    public ApiResponse<SurveyDto> addResponse(@PathParam("id") UUID surveyId, @Valid ResponseRequest request,
                                              @Context SecurityContext sc) {
        return ApiResponse.ok(surveyService.addResponse(surveyId, request));
    }

    @POST
    @Path("/{id}/complete")
    @RolesAllowed({"SURVEYOR", "ADMIN", "SUPERVISOR"})
    public ApiResponse<SurveyDto> complete(@PathParam("id") UUID surveyId, @Context SecurityContext sc) {
        return ApiResponse.ok(surveyService.completeSurvey(surveyId));
    }

    @POST
    @Path("/batch-sync")
    @RolesAllowed({"SURVEYOR", "ADMIN", "SUPERVISOR"})
    public ApiResponse<List<BatchSyncResultItem>> batchSync(@Valid BatchSyncRequest request, @Context SecurityContext sc) {
        UUID surveyorId = resolveUserId(sc);
        return ApiResponse.ok(surveyService.batchSync(surveyorId, request));
    }

    @GET
    @Path("/{id}")
    @RolesAllowed({"SURVEYOR", "ADMIN", "SUPERVISOR"})
    public ApiResponse<SurveyDto> get(@PathParam("id") UUID surveyId) {
        return ApiResponse.ok(surveyService.getSurvey(surveyId));
    }

    private UUID resolveUserId(SecurityContext sc) {
        String username = sc.getUserPrincipal().getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new NotAuthorizedException("User not found"));
        return user.getId();
    }
}

package com.votersentiment.questionnaire.resource;

import com.votersentiment.common.ApiResponse;
import com.votersentiment.common.PagedResponse;
import com.votersentiment.questionnaire.dto.QuestionnaireDto;
import com.votersentiment.questionnaire.dto.QuestionnaireSummaryDto;
import com.votersentiment.questionnaire.service.QuestionnaireService;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;

import java.util.List;
import java.util.UUID;

@Path("/surveyor")
@Produces(MediaType.APPLICATION_JSON)
public class SurveyorResource {

    @Inject
    QuestionnaireService questionnaireService;

    @GET
    @Path("/questionnaires")
    @RolesAllowed({"SURVEYOR", "ADMIN", "SUPERVISOR"})
    public ApiResponse<List<QuestionnaireSummaryDto>> listActive() {
        // TODO: filter by surveyor assigned region / language once rules are defined
        PagedResponse<QuestionnaireSummaryDto> page = questionnaireService.list(0, 1000);
        return ApiResponse.ok(page.getContent().stream().filter(QuestionnaireSummaryDto::isActive).toList());
    }

    @GET
    @Path("/questionnaire/{id}/full")
    @RolesAllowed({"SURVEYOR", "ADMIN", "SUPERVISOR"})
    public ApiResponse<QuestionnaireDto> getFull(@PathParam("id") UUID id) {
        return ApiResponse.ok(questionnaireService.getFullForSurveyor(id));
    }
}

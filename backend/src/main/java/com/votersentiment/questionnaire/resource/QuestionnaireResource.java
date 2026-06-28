package com.votersentiment.questionnaire.resource;

import io.smallrye.common.annotation.Blocking;

import com.votersentiment.common.ApiResponse;
import com.votersentiment.common.PagedResponse;
import com.votersentiment.excel.ExcelExportService;
import com.votersentiment.excel.ExcelImportService;
import com.votersentiment.excel.dto.UploadPreviewDto;
import com.votersentiment.questionnaire.dto.QuestionnaireDto;
import com.votersentiment.questionnaire.dto.QuestionnaireSummaryDto;
import com.votersentiment.questionnaire.service.QuestionnaireService;
import com.votersentiment.user.User;
import com.votersentiment.user.UserRepository;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.SecurityContext;
import org.jboss.resteasy.reactive.RestForm;
import org.jboss.resteasy.reactive.multipart.FileUpload;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.UUID;

@Blocking
@Path("/admin/questionnaire")
@Produces(MediaType.APPLICATION_JSON)
public class QuestionnaireResource {

    @Inject
    QuestionnaireService questionnaireService;

    @Inject
    ExcelImportService excelImportService;

    @Inject
    ExcelExportService excelExportService;

    @Inject
    UserRepository userRepository;

    @POST
    @Path("/upload")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @RolesAllowed({"ADMIN", "SUPERVISOR"})
    public ApiResponse<UploadPreviewDto> upload(@RestForm("file") FileUpload file) throws IOException {
        try (InputStream is = Files.newInputStream(file.uploadedFile())) {
            UploadPreviewDto preview = excelImportService.parseWorkbook(is, file.fileName());
            return ApiResponse.ok(preview);
        }
    }

    @POST
    @Path("/save")
    @Consumes(MediaType.APPLICATION_JSON)
    @RolesAllowed({"ADMIN", "SUPERVISOR"})
    public ApiResponse<QuestionnaireDto> save(@Valid QuestionnaireDto dto, @Context SecurityContext sc) {
        UUID creatorId = resolveUserId(sc);
        return ApiResponse.ok(questionnaireService.createFromDto(creatorId, dto));
    }

    @GET
    @Path("/questionnaires")
    @RolesAllowed({"ADMIN", "SUPERVISOR"})
    public ApiResponse<PagedResponse<QuestionnaireSummaryDto>> list(@QueryParam("page") @DefaultValue("0") int page,
                                                                    @QueryParam("size") @DefaultValue("20") int size) {
        return ApiResponse.ok(questionnaireService.list(page, size));
    }

    @GET
    @Path("/{id}")
    @RolesAllowed({"ADMIN", "SUPERVISOR"})
    public ApiResponse<QuestionnaireDto> get(@PathParam("id") UUID id) {
        return ApiResponse.ok(questionnaireService.getById(id));
    }

    @PUT
    @Path("/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @RolesAllowed({"ADMIN", "SUPERVISOR"})
    public ApiResponse<QuestionnaireDto> update(@PathParam("id") UUID id, @Valid QuestionnaireDto dto) {
        return ApiResponse.ok(questionnaireService.update(id, dto));
    }

    @PUT
    @Path("/{id}/activate")
    @RolesAllowed({"ADMIN", "SUPERVISOR"})
    public ApiResponse<QuestionnaireDto> activate(@PathParam("id") UUID id) {
        return ApiResponse.ok(questionnaireService.activate(id));
    }

    @PUT
    @Path("/{id}/deactivate")
    @RolesAllowed({"ADMIN", "SUPERVISOR"})
    public ApiResponse<QuestionnaireDto> deactivate(@PathParam("id") UUID id) {
        return ApiResponse.ok(questionnaireService.deactivate(id));
    }

    @DELETE
    @Path("/{id}")
    @RolesAllowed({"ADMIN", "SUPERVISOR"})
    public ApiResponse<Void> delete(@PathParam("id") UUID id) {
        questionnaireService.delete(id);
        return ApiResponse.ok(null, "Questionnaire deleted");
    }

    @GET
    @Path("/{id}/export-template")
    @Produces("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
    @RolesAllowed({"ADMIN", "SUPERVISOR"})
    public Response exportTemplate(@PathParam("id") UUID id) throws IOException {
        byte[] data = excelExportService.exportTemplate(id);
        return Response.ok(data)
                .header("Content-Disposition", "attachment; filename=\"template.xlsx\"")
                .build();
    }

    @GET
    @Path("/{id}/export-responses")
    @Produces("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
    @RolesAllowed({"ADMIN", "SUPERVISOR"})
    public Response exportResponses(@PathParam("id") UUID id) throws IOException {
        byte[] data = excelExportService.exportResponses(id);
        return Response.ok(data)
                .header("Content-Disposition", "attachment; filename=\"responses.xlsx\"")
                .build();
    }

    private UUID resolveUserId(SecurityContext sc) {
        String username = sc.getUserPrincipal().getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new NotAuthorizedException("User not found"));
        return user.getId();
    }
}

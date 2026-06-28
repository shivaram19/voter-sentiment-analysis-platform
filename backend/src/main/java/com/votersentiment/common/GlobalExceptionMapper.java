package com.votersentiment.common;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.ConstraintViolationException;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.UriInfo;
import jakarta.ws.rs.ext.ExceptionMapper;
import jakarta.ws.rs.ext.Provider;
import lombok.extern.slf4j.Slf4j;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Provider
public class GlobalExceptionMapper implements ExceptionMapper<Throwable> {

    @Context
    UriInfo uriInfo;

    @Override
    public Response toResponse(Throwable exception) {
        String path = uriInfo != null ? uriInfo.getPath() : null;
        log.error("Unhandled exception at {}", path, exception);

        if (exception instanceof ConstraintViolationException cve) {
            Map<String, String> errors = new HashMap<>();
            for (ConstraintViolation<?> v : cve.getConstraintViolations()) {
                String propertyPath = v.getPropertyPath().toString();
                errors.put(propertyPath, v.getMessage());
            }
            ApiResponse<ErrorResponse> body = ApiResponse.<ErrorResponse>builder()
                    .success(false)
                    .message("Request validation failed")
                    .data(ErrorResponse.builder()
                            .status(Response.Status.BAD_REQUEST.getStatusCode())
                            .error("Validation failed")
                            .message("Request validation failed")
                            .path(path)
                            .fieldErrors(errors)
                            .build())
                    .path(path)
                    .build();
            return Response.status(Response.Status.BAD_REQUEST).entity(body).build();
        }

        if (exception instanceof WebApplicationException wae) {
            Response original = wae.getResponse();
            String reason = Response.Status.fromStatusCode(original.getStatus()) != null
                    ? Response.Status.fromStatusCode(original.getStatus()).getReasonPhrase()
                    : "Error";
            ApiResponse<ErrorResponse> body = ApiResponse.<ErrorResponse>builder()
                    .success(false)
                    .message(wae.getMessage())
                    .data(ErrorResponse.builder()
                            .status(original.getStatus())
                            .error(reason)
                            .message(wae.getMessage())
                            .path(path)
                            .build())
                    .path(path)
                    .build();
            return Response.status(original.getStatus()).entity(body).build();
        }

        ApiResponse<ErrorResponse> body = ApiResponse.<ErrorResponse>builder()
                .success(false)
                .message("An unexpected error occurred")
                .data(ErrorResponse.builder()
                        .status(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode())
                        .error("Internal server error")
                        .message("An unexpected error occurred")
                        .path(path)
                        .build())
                .path(path)
                .build();
        return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity(body).build();
    }
}

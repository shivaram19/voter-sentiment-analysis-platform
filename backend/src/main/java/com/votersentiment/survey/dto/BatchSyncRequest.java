package com.votersentiment.survey.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

import java.util.List;

@Data
public class BatchSyncRequest {

    @NotEmpty(message = "At least one survey is required")
    @Valid
    private List<BatchSyncItem> surveys;
}

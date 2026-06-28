package com.votersentiment.survey;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.Instant;
import java.util.UUID;

@Data
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "survey", uniqueConstraints = {
        @UniqueConstraint(columnNames = {"surveyor_id", "client_survey_id"})
})
public class Survey extends PanacheEntityBase {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "questionnaire_id", nullable = false)
    private UUID questionnaireId;

    @Column(name = "surveyor_id", nullable = false)
    private UUID surveyorId;

    @Column(name = "client_survey_id", nullable = false)
    private UUID clientSurveyId;

    private String respondentName;

    private Integer respondentAge;

    private String respondentGender;

    private String state;

    private String district;

    private String taluka;

    private String village;

    private Double gpsLatitude;

    private Double gpsLongitude;

    private Double gpsAccuracy;

    private String languageUsed;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    @Builder.Default
    private SyncStatus syncStatus = SyncStatus.PENDING;

    private Instant startedAt;

    private Instant submittedAt;

    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private Instant createdAt;

    @UpdateTimestamp
    @Column(nullable = false)
    private Instant updatedAt;
}

package com.votersentiment.survey.repo;

import com.votersentiment.survey.Survey;
import com.votersentiment.survey.SyncStatus;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import io.quarkus.panache.common.Page;
import io.quarkus.panache.common.Sort;
import jakarta.enterprise.context.ApplicationScoped;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class SurveyRepository implements PanacheRepositoryBase<Survey, UUID> {

    public Optional<Survey> findByClientSurveyId(UUID surveyorId, UUID clientSurveyId) {
        return find("surveyorId = ?1 and clientSurveyId = ?2", surveyorId, clientSurveyId)
                .firstResultOptional();
    }

    public List<Survey> findByQuestionnaire(UUID questionnaireId, int page, int size) {
        return find("questionnaireId = ?1", Sort.by("createdAt").descending(), questionnaireId)
                .page(Page.of(page, size))
                .list();
    }

    public long countBySyncStatus(SyncStatus status) {
        return count("syncStatus = ?1", status);
    }

    public long countByQuestionnaire(UUID questionnaireId) {
        return count("questionnaireId = ?1", questionnaireId);
    }
}

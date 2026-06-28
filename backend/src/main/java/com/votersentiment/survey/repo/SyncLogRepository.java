package com.votersentiment.survey.repo;

import com.votersentiment.survey.SyncLog;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import jakarta.enterprise.context.ApplicationScoped;

import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class SyncLogRepository implements PanacheRepositoryBase<SyncLog, UUID> {

    public List<SyncLog> findBySurvey(UUID surveyId) {
        return list("surveyId = ?1 order by createdAt desc", surveyId);
    }
}

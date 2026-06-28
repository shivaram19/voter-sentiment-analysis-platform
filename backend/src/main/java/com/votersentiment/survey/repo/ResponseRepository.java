package com.votersentiment.survey.repo;

import com.votersentiment.survey.Response;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import jakarta.enterprise.context.ApplicationScoped;

import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class ResponseRepository implements PanacheRepositoryBase<Response, UUID> {

    public List<Response> findBySurvey(UUID surveyId) {
        return list("surveyId = ?1", surveyId);
    }

    public List<Response> findByQuestionnaire(UUID questionnaireId) {
        return list("select r from Response r join Survey s on r.surveyId = s.id where s.questionnaireId = ?1", questionnaireId);
    }

    public void deleteBySurvey(UUID surveyId) {
        delete("surveyId = ?1", surveyId);
    }
}

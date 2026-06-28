package com.votersentiment.questionnaire.repo;

import com.votersentiment.questionnaire.QuestionGroup;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import jakarta.enterprise.context.ApplicationScoped;

import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class QuestionGroupRepository implements PanacheRepositoryBase<QuestionGroup, UUID> {

    public List<QuestionGroup> findByQuestionnaire(UUID questionnaireId) {
        return list("questionnaire.id = ?1 order by sheetOrder", questionnaireId);
    }
}

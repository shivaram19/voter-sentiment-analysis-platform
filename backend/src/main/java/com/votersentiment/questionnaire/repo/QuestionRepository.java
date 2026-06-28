package com.votersentiment.questionnaire.repo;

import com.votersentiment.questionnaire.Question;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import jakarta.enterprise.context.ApplicationScoped;

import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class QuestionRepository implements PanacheRepositoryBase<Question, UUID> {

    public List<Question> findByQuestionGroup(UUID groupId) {
        return list("questionGroup.id = ?1 order by displayOrder", groupId);
    }

    public List<Question> findByQuestionnaire(UUID questionnaireId) {
        return list("select q from Question q join q.questionGroup g where g.questionnaire.id = ?1 order by g.sheetOrder, q.displayOrder",
                questionnaireId);
    }
}

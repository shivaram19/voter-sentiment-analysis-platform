package com.votersentiment.questionnaire.repo;

import com.votersentiment.questionnaire.Questionnaire;
import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import io.quarkus.panache.common.Page;
import io.quarkus.panache.common.Sort;
import jakarta.enterprise.context.ApplicationScoped;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class QuestionnaireRepository implements PanacheRepositoryBase<Questionnaire, UUID> {

    public Optional<Questionnaire> findActiveById(UUID id) {
        return find("id = ?1 and deletedAt is null", id).firstResultOptional();
    }

    public List<Questionnaire> listActive(int page, int size, String sort) {
        return find("deletedAt is null", Sort.by(sort).descending())
                .page(Page.of(page, size))
                .list();
    }

    public long countActive() {
        return count("deletedAt is null");
    }

    public List<Questionnaire> listActiveForSurveyor(UUID region) {
        // TODO: refine filter by assigned region / language once business rules are final
        return list("isActive = true and deletedAt is null");
    }
}

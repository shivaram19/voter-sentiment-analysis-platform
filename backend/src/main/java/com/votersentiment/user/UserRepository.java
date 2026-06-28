package com.votersentiment.user;

import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import io.quarkus.panache.common.Page;
import io.quarkus.panache.common.Sort;
import jakarta.enterprise.context.ApplicationScoped;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class UserRepository implements PanacheRepositoryBase<User, UUID> {

    public Optional<User> findByUsername(String username) {
        return find("username = ?1 and deletedAt is null", username).firstResultOptional();
    }

    public Optional<User> findActiveById(UUID id) {
        return find("id = ?1 and deletedAt is null", id).firstResultOptional();
    }

    public List<User> listActive(int page, int size, String sort) {
        return find("deletedAt is null", Sort.by(sort).ascending())
                .page(Page.of(page, size))
                .list();
    }

    public long countActive() {
        return count("deletedAt is null");
    }

    public boolean existsByUsername(String username) {
        return count("username = ?1 and deletedAt is null", username) > 0;
    }
}

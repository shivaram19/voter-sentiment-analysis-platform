package com.votersentiment.auth;

import io.quarkus.hibernate.orm.panache.PanacheRepositoryBase;
import jakarta.enterprise.context.ApplicationScoped;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class RefreshTokenRepository implements PanacheRepositoryBase<RefreshToken, UUID> {

    public Optional<RefreshToken> findValidByHash(String tokenHash) {
        return find("tokenHash = ?1 and revoked = false and reused = false and expiresAt > ?2",
                tokenHash, Instant.now())
                .firstResultOptional();
    }

    public void revokeFamily(String family) {
        update("revoked = true where family = ?1", family);
    }
}

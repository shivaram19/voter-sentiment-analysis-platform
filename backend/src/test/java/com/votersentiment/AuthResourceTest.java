package com.votersentiment;

import com.votersentiment.auth.dto.LoginRequest;
import com.votersentiment.auth.dto.LoginResponse;
import com.votersentiment.auth.dto.RegisterRequest;
import com.votersentiment.user.Role;
import io.quarkus.test.junit.QuarkusTest;
import io.quarkus.test.security.TestSecurity;
import io.restassured.http.ContentType;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.hamcrest.Matchers.equalTo;

@QuarkusTest
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class AuthResourceTest {

    private static String refreshToken;

    @Test
    @Order(1)
    @TestSecurity(user = "admin", roles = {"ADMIN"})
    public void testRegister() {
        RegisterRequest request = new RegisterRequest();
        request.setUsername("surveyor1");
        request.setPassword("password123");
        request.setName("Field Surveyor");
        request.setEmail("surveyor1@test.in");
        request.setRole(Role.SURVEYOR);

        given()
            .contentType(ContentType.JSON)
            .body(request)
        .when()
            .post("/api/auth/register")
        .then()
            .statusCode(200)
            .body("success", equalTo(true))
            .body("data.username", equalTo("surveyor1"));
    }

    @Test
    @Order(2)
    public void testLogin() {
        LoginRequest request = new LoginRequest();
        request.setUsername("surveyor1");
        request.setPassword("password123");

        LoginResponse response = given()
            .contentType(ContentType.JSON)
            .body(request)
        .when()
            .post("/api/auth/login")
        .then()
            .statusCode(200)
            .body("success", equalTo(true))
            .body("data.accessToken", notNullValue())
            .extract().jsonPath().getObject("data", LoginResponse.class);

        refreshToken = response.getRefreshToken();
    }

    @Test
    @Order(3)
    public void testRefresh() {
        given()
            .contentType(ContentType.JSON)
            .body("{\"refreshToken\":\"" + refreshToken + "\"}")
        .when()
            .post("/api/auth/refresh")
        .then()
            .statusCode(200)
            .body("success", equalTo(true))
            .body("data.accessToken", notNullValue())
            .body("data.refreshToken", notNullValue());
    }

    @Test
    @Order(4)
    public void testRefreshTokenRotationAndReuseDetection() {
        // Rotate once
        LoginResponse rotated = given()
            .contentType(ContentType.JSON)
            .body("{\"refreshToken\":\"" + refreshToken + "\"}")
        .when()
            .post("/api/auth/refresh")
        .then()
            .statusCode(200)
            .body("success", equalTo(true))
            .extract().jsonPath().getObject("data", LoginResponse.class);

        // Replaying the old refresh token must be rejected and revoke the family.
        given()
            .contentType(ContentType.JSON)
            .body("{\"refreshToken\":\"" + refreshToken + "\"}")
        .when()
            .post("/api/auth/refresh")
        .then()
            .statusCode(401);

        // The rotated token must also be rejected because its family was revoked.
        given()
            .contentType(ContentType.JSON)
            .body("{\"refreshToken\":\"" + rotated.getRefreshToken() + "\"}")
        .when()
            .post("/api/auth/refresh")
        .then()
            .statusCode(401);
    }
}

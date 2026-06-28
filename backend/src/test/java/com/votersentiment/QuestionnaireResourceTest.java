package com.votersentiment;

import com.votersentiment.auth.dto.LoginRequest;
import com.votersentiment.auth.dto.LoginResponse;
import com.votersentiment.user.Role;
import io.quarkus.test.junit.QuarkusTest;
import io.quarkus.test.security.TestSecurity;
import io.restassured.http.ContentType;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.notNullValue;

@QuarkusTest
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class QuestionnaireResourceTest {

    private String accessToken;

    @BeforeAll
    @TestSecurity(user = "admin", roles = {"ADMIN"})
    public void setup() {
        var register = new com.votersentiment.auth.dto.RegisterRequest();
        register.setUsername("admin2");
        register.setPassword("password123");
        register.setName("Admin Two");
        register.setRole(Role.ADMIN);
        given().contentType(ContentType.JSON).body(register).post("/api/auth/register");

        LoginRequest login = new LoginRequest();
        login.setUsername("admin2");
        login.setPassword("password123");
        LoginResponse response = given()
            .contentType(ContentType.JSON)
            .body(login)
        .when()
            .post("/api/auth/login")
        .then()
            .extract().jsonPath().getObject("data", LoginResponse.class);
        accessToken = response.getAccessToken();
    }

    @Test
    public void testListQuestionnaires() {
        given()
            .auth().oauth2(accessToken)
        .when()
            .get("/api/admin/questionnaire/questionnaires?page=0&size=10")
        .then()
            .statusCode(200)
            .body("success", equalTo(true))
            .body("data", notNullValue());
    }
}

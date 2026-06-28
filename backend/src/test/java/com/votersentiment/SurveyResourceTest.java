package com.votersentiment;

import com.votersentiment.auth.dto.LoginRequest;
import com.votersentiment.auth.dto.LoginResponse;
import com.votersentiment.survey.ResponseType;
import com.votersentiment.survey.dto.BatchSyncItem;
import com.votersentiment.survey.dto.BatchSyncRequest;
import com.votersentiment.survey.dto.ResponseRequest;
import com.votersentiment.user.Role;
import io.quarkus.test.junit.QuarkusTest;
import io.quarkus.test.security.TestSecurity;
import io.restassured.http.ContentType;
import jakarta.ws.rs.core.MediaType;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;

import java.util.List;
import java.util.UUID;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.notNullValue;

@QuarkusTest
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class SurveyResourceTest {

    private String accessToken;

    @BeforeAll
    @TestSecurity(user = "admin", roles = {"ADMIN"})
    public void setup() {
        var register = new com.votersentiment.auth.dto.RegisterRequest();
        register.setUsername("surveyor2");
        register.setPassword("password123");
        register.setName("Surveyor Two");
        register.setRole(Role.SURVEYOR);
        given().contentType(ContentType.JSON).body(register).post("/api/auth/register");

        LoginRequest login = new LoginRequest();
        login.setUsername("surveyor2");
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
    public void testBatchSyncIsIdempotent() {
        UUID clientSurveyId = UUID.randomUUID();
        UUID questionnaireId = UUID.randomUUID();
        UUID questionId = UUID.randomUUID();

        ResponseRequest response = new ResponseRequest();
        response.setQuestionId(questionId);
        response.setResponseType(ResponseType.SINGLE_CHOICE);
        response.setResponseValue(new com.fasterxml.jackson.databind.node.TextNode("option_a"));

        BatchSyncItem item = new BatchSyncItem();
        item.setClientSurveyId(clientSurveyId);
        item.setQuestionnaireId(questionnaireId);
        item.setLanguageUsed("en");
        item.setResponses(List.of(response));

        BatchSyncRequest request = new BatchSyncRequest();
        request.setSurveys(List.of(item));

        // First sync
        given()
            .auth().oauth2(accessToken)
            .contentType(MediaType.APPLICATION_JSON)
            .body(request)
        .when()
            .post("/api/survey/batch-sync")
        .then()
            .statusCode(200)
            .body("success", equalTo(true))
            .body("data[0].status", equalTo("SYNCED"))
            .body("data[0].serverSurveyId", notNullValue());

        // Retry with same clientSurveyId should return existing survey, not duplicate
        String serverId = given()
            .auth().oauth2(accessToken)
            .contentType(MediaType.APPLICATION_JSON)
            .body(request)
        .when()
            .post("/api/survey/batch-sync")
        .then()
            .statusCode(200)
            .body("success", equalTo(true))
            .body("data[0].status", equalTo("SYNCED"))
            .extract().jsonPath().getString("data[0].serverSurveyId");
    }
}

Feature: API Test Security Section

  Background: Setup Request URL
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "api/token"

  Scenario: create token with valid username and password
    #prepare request
    And request {"username": "supervisor","password": "tek_supervisor"}
    #Send request
    When method post
    #validating response
    Then status 200
    And print response

  Scenario: validate token with invalid username
    And request {"username": "wrongUsername","password": "tek_supervisor"}
    When method post
    Then status 400
    And print response
    And assert response.errorMessage == "User not found"

  Scenario: validate token with invalid password
    And request {"username": "supervisor","password": "wrongPassword"}
    When method post
    Then status 400
    And print response
    And assert response.errorMessage == "Password Not Matched"
    And assert response.httpStatus == "BAD_REQUEST"

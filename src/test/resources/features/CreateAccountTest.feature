#Scenario 10:
#Endpoint = /api/accounts/add-primary-account.
#Status Code = 201
#Assert Email Address
#Notes:
#duplicate email not accepted
#For Gender and maritalStatus You have to use the Predefined values.
#Once you create Account validate database and take screenshot.
#FirstName and LastName should be your name.
#In Request body we don't need id and isNew field (you can remove them).

Feature: Create Account Test

  Background: API Test Setup
    * def result = callonce read('GenerateToken.feature')
    And print result
    And def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  @test
  Scenario: Create Account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer "  + generatedToken
    And request
      """
      {
      "email": "Anil@gmail.com",
      "firstName": "Anil",
      "lastName": "Qaderi",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "SINGLE",
      "employmentStatus": "Unemployed",
      "dateOfBirth": "2022-01-12"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == "Anil@gmail.com"
    # Delete created account
    Given path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = response.id
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"

@Regression
Feature: Get Account API

  #Scenario 9:
  #Endpoint = /api/accounts/get-account
  #For primaryPersonId = <One of your accounts already Created
  #Make sure email address is correct.
  
  Background: API Setup steps
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Get API Call with existing account
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    #Scenario 9:
    #Endpoint = /api/accounts/get-account
    #For primaryPersonId = 6824
    #Make sure email address is "yamaahmad20@gmail.com"
    # def step to define new variable in karate framwork
    * def generatedToken = response.token
    Given path "/api/accounts/get-account"
    And param primaryPersonId = 6824
    And header Authorization = "Bearer " + generatedToken
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == 6824
    And assert response.primaryPerson.email == "yamaahmad20@gmail.com"

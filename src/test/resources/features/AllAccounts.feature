Feature: accouts all accounts

  Background: API Test Setup
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"
    
    Scenario: verify get all accounts
    * def dataGenerator = Java.type('api.data.GenereteData')
    * def emailAddressData = dataGenerator.getEmail()
    Given path "/api/accounts/get-all-accounts"
    And header Authorization = "Bearer " + generatedToken
    When method get
    Then status 200
    And request
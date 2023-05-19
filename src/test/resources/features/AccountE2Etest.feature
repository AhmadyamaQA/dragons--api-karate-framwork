#End 2 End Account Testsing.
# Create Account
# Add Address
# Add Phone
# Add Car
# Get Account
#Note: Everything in 1 scenario.
@Regression
Feature: End-to-End Account Testsing.

  Background: API Test Setup
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: End-to-End Account Creation Testing
    * def dataGenerator = Java.type('api.data.GenereteData')
    * def emailAddressData = dataGenerator.getEmail()
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {
      "email": "#(emailAddressData)",
      "firstName": "Ahmadyama",
      "lastName": "Qaderi",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Software Developer",
      "dateOfBirth": "1990-02-01"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == emailAddressData
    And assert response.firstName == "Ahmadyama"
    * def generatedAccountId = response.id
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {
      "addressType": "Home",
      "addressLine1": "123 Sheldon Street",
      "city": "Elk Grove ",
      "state": "California",
      "postalCode": "95756",
      "countryCode": "",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.addressLine1 == "123 Sheldon Street"
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + generatedToken
    * def randomPhoneNumber = dataGenerator.getPhoneNumber()
    And request
      """
      {
      "phoneNumber": "#(randomPhoneNumber)",
      "phoneExtension": "",
      "phoneTime": "Morning",
      "phoneType": "Mobile"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.phoneNumber == randomPhoneNumber
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + generatedToken
    * def randomLicensePlate = dataGenerator.getLicensePlate()
    And request
      """
      {
      "make": "Tesla",
      "model": "Y",
      "year": "2023",
      "licensePlate": "#(randomLicensePlate)"
      }
      """
    When method post
    And status 201
    And print response
    And assert response.licensePlate == randomLicensePlate
    Given path "/api/accounts/get-account"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + generatedToken
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == generatedAccountId

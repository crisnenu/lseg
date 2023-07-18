Feature: Sample API Tests

  Background:
    * url 'https://reqres.in/api'
    * header Accept = 'application/json'
    * def expectedOutput = read("response1.json")
    * def data = Java.type('examples.DataStore');

  Scenario:  Test a Sample Get API

    Given url 'https://reqres.in/api/users?page=2'
    And params {limit:2, offset:0}
    When method GET
    Then status 200
    And print response
    And match response.data == '#array'
    And match $.total == 12
    And match response.data == '#[6]'
    And print responseStatus
    And print responseTime
    And print responseHeaders
    And print responseCookies

  Scenario:  Test a Get API Background

    Given path '/users?page=2'
    When method GET
    Then status 200
    And print response

  Scenario: Test background, path and params

    Given path '/users'
    And param page = 2
    When method GET
    Then status 200
    And print response

  Scenario: Test get with assertions

    Given path '/users'
    And param page = 2
    When method GET
    Then status 200
    And match response.data[0].first_name != null
    And assert response.data.length == 6
    And match $.data[1].id == 8
    And match $.data[3].last_name == 'Fields'

  Scenario: Test POST API
    Given path '/users'
    And request {"name":"NENU","job":"tester"}
    When method POST
    Then status 201
    And print response

  Scenario: Test POST API with assertions
    Given path '/users'
    And request {"name":"NENU","job":"tester"}
    When method POST
    Then status 201
    And print response
    And match response == {"createdAt": "#ignore","name": "NENU","id": "#string","job": "tester"}

  Scenario: Test POST API with assertions from file
    Given path '/users'
    And request {"name":"NENU","job":"tester"}
    When method POST
    Then status 201
    And print response
    And match $ == expectedOutput

  Scenario: Test POST API with assertions from file
    Given path '/users'
    And def requestInput = read("request1.json")
    And request requestInput
    When method POST
    Then status 201
    And print response
    And match response == expectedOutput

  Scenario: Test POST API with assertions from file path
    Given path '/users'
    And def requestInput = read("file:"+ karate.properties['user.dir'] + '\\src\\data\\request1.json')
    And def expectedOutput = read("file:"+ karate.properties['user.dir'] + '\\src\\data\\response1.json')
    And request requestInput
    When method POST
    Then status 201
    And print response
    And match response == expectedOutput

  Scenario: Test POST API with assertions from file path
    Given path '/users'
    And def requestInput = read("file:"+ karate.properties['user.dir'] + '\\src\\data\\request1.json')
    And def expectedOutput = read("file:"+ karate.properties['user.dir'] + '\\src\\data\\response1.json')
    And request requestInput
    And set requestInput.job = 'engineer'
    When method POST
    Then status 201
    And print response
    And match response.job != expectedOutput.job

  Scenario: Test PUT API with assertions from file path
    Given path '/users/2'
    And def requestInput = read("file:"+ karate.properties['user.dir'] + '\\src\\data\\request1.json')
    And def expectedOutput = read("file:"+ karate.properties['user.dir'] + '\\src\\data\\response1.json')
    And request requestInput
    And set requestInput.name = 'morpheus'
    When method PUT
    Then status 200
    And print response
    And remove expectedOutput.id
    And remove expectedOutput.createdAt
    And set expectedOutput.updatedAt = "#ignore"
    And set expectedOutput.name = requestInput.name
    And match response == expectedOutput

  Scenario: Test Delete Method
    Given path "/users/2"
    When method DELETE
    Then status 204
    And print response

  Scenario: Karate Config
    Given print name
    And print baseURL

  @env
  Scenario: Karate Config Get
    #mvn test -Denv=default
    #mvn clean install
    #mvn test -Dtest=FirstTestRunner#testTags
    #mvn test -Dkarate.options=="--tags @dev" @ignore
    Given url baseURL + '/users?page=2'
    When method GET
    Then status 200
    And print response

  @dataStore
  Scenario: Use DataStore
    Given data.putData("url", baseURL + '/users?page=2')
    And def newURL = data.getData("url")
    And print newURL
    And url newURL
    When method GET
    Then status 200
    And print response
    And def name = data.putData("name", response.data[0].first_name)
    And match response.data[0].first_name == data.getData("name")

    #webSocket

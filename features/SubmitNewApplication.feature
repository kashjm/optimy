Feature: Submitting an Application on Optimy Website

  Scenario: Submitting a New Application on Optimy Website
    Given I open the browser and navigate to the Optimy website
    And I wait for and accept all cookies
    When I click the "Login" button to go to the login page
    And I enter my email address
    And I enter my password
    And I click the "Login" button
    And I click the "Submit a new application" button
    Then if "Continue with the submission of the application" is present
    And I click the "Submit a new application" button at the bottom
    And I fill out the forms
    And I click the "Next screen" button
    Then I verify all the inputted values are displayed in the Summary screen
    And I click the "Validate and send" button
    Then I verify I am redirected to the "Thank you for submitting your project" page
@javascript
Feature: Manage thing arguments
  In order to get arguments for things
  An user
  wants to add an argument to a thing
  
  Background:
       
    Given a user named "user"
    And I log in as "user"
    
  Scenario: Default
    Given a thing
    When I am on the thing arguments page
    And I press ".add_argument_button" by JavaScript
    And I press ".add_argument_button" by JavaScript
    And I fill in xpath "//*[contains(concat(' ', normalize-space(@placeholder), ' '), ' Topic ')]" with "Height"
    And I fill in xpath "//*[contains(concat(' ', normalize-space(@placeholder), ' '), ' Value ')]" with "1"
    And I press ".save_argument_button" by JavaScript
    Then I should see "Height"
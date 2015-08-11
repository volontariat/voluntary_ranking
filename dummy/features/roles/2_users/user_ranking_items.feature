@javascript
Feature: Manage user ranking items
  In order to get user rankings
  An user
  wants to add an user ranking item
  
  Background:
       
    Given a user named "user"
    And I log in as "user"
    
  Scenario: Default
    When I am on the products ranking page
    And I press ".your_ranking_button" by JavaScript
    And I fill in xpath "//*[contains(concat(' ', normalize-space(@class), ' '), ' adjective ')]" with "best"
    And I fill in xpath "//*[contains(concat(' ', normalize-space(@class), ' '), ' negative_adjective ')]" with "worst"
    And I fill in xpath "//*[contains(concat(' ', normalize-space(@class), ' '), ' topic ')]" with "movie"
    And I fill in xpath "//*[contains(concat(' ', normalize-space(@class), ' '), ' scope ')]" with "ever"
    And I press ".get_ranking_button" by JavaScript
    Then I should see "No items found."
    When I fill in xpath "//*[contains(concat(' ', normalize-space(@class), ' '), ' thing_name ')]" with "Dummy2"
    And I press ".add_user_ranking_item_button" by JavaScript
    When I follow "Dummy2"
    Then I should see "Dummy2"
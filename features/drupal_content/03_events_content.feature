@api
Feature: Content Type Event
  As an anonymous user
  I want to view data related to an Event
  So that I can decide it is something I would like to attend.

  Scenario: Add an event node and verify that the necessary fields exist.
    Given I am an anonymous user
    And an "Event Terms" term with the name "camp"
    And an "Event Terms" term with the name "drupal"
    And "event" content:
      | title | field_event_location | field_event_date | field_event_tags | status |
      | Florida Drupal Camp | Orlando | 2015-04-11 9:00:00 | camp, drupal | 1 |
    When I am at "content/florida-drupal-camp"
    Then I should see the text "Florida Drupal Camp"
    And I should see the text "Orlando"
    And I should see the text "Saturday, April 11, 2015"
    And I should see the text "camp"
    And I should see the text "drupal"
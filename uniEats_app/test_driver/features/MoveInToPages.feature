Feature: UniEats_Pages


  Scenario: Counter increases when the button is pressed (1)
    Given I expect the "counter" to be "0"
    When I tap the "increment" button
    And I tap the "increment" button
    Then I expect the "counter" to be "2"


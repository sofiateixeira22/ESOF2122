Feature: UniEats_Pages

  Scenario: enter uniEats page, from uni page
    Given I go to the "uni_page" page
    When I tap the "uniEats_Button1" button
    Then I expect the widget 'uniEats_page' to be present within 2 seconds

  Scenario: enter uni page, from uniEats page
    Given I go to the "uniEats_page" page
    When I tap the "uni_Button1" button
    Then I expect the widget 'uni_page' to be present within 2 seconds

  Scenario: enter uniEats favoritos page, from uniEats page
    Given I go to the "uniEats_page" page
    When I tap the "uniEats_favoritos_Button1" button
    Then I expect the widget 'uniEats_favoritos_widget' to be present within 2 seconds



    Then I expect the icon 'notification' to be present within 1 second




  Scenario: Counter increases when the button is pressed (1)
    Given I expect the "counter" to be "0"
    When I tap the "increment" button
    And I tap the "increment" button
    Then I expect the "counter" to be "2"


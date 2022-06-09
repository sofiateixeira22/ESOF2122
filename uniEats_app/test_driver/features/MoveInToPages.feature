

Feature: UniEats_Pages

  Scenario: enter uniEats page, from uni page
    Given I tap the 'uni_page' widget
    When I tap the 'uniEats_Button1' button
    Then I expect the widget 'uniEats_page' to be present within 2 seconds

  Scenario: enter uni page, from uniEats page
    Given I tap the 'uniEats_page' widget
    When I tap the "uni_Button1" button
    Then I expect the widget 'uni_page' to be present within 2 seconds

  Scenario: enter restaurant page, from uniEats page
    Given I go to the "uniEats_page" page
    When I tap the "uniEats_restaurant_card_widget" button
    Then I expect the widget 'uniEats_restaurant_page' to be present within 2 seconds

  Scenario: enter uniEats page, from restaurant page
    Given I go to the "uniEats_restaurant_page" page
    When I tap the "uniEats_Button1" button
    Then I expect the widget 'uniEats_page' to be present within 2 seconds

  Scenario: enter favoritos page, from uniEats page
    Given I go to the "uniEats_page" page
    When I tap the "uniEats_favoritos_Button1" button
    Then I expect the widget 'uniEats_favoritos_page' to be present within 2 seconds

  Scenario: enter uniEats page, from favoritos page
    Given I go to the "uniEats_favoritos_page" page
    When I tap the "uniEats_Button1" button
    Then I expect the widget 'uniEats_page' to be present within 2 seconds

  Scenario: enter historico page, from uniEats page
    Given I go to the "uniEats_page" page
    When I tap the "uniEats_historico_Button1" button
    Then I expect the widget 'uniEats_historico_widget' to be present within 2 seconds

  Scenario: enter historico page, from uniEats page
    Given I go to the "uniEats_historico_widget" page
    When I tap the "uniEats_Button1" button
    Then I expect the widget 'uniEats_page' to be present within 2 seconds

  Scenario: enter SobreNos page, from uniEats page
    Given I go to the "uniEats_page" page
    When I tap the "uniEats_SobreNos_Button1" button
    Then I expect the widget 'uniEats_SobreNos_page' to be present within 2 seconds

  Scenario: enter uniEats page, from SobreNos page
    Given I go to the ´uniEats_SobreNos_page´ page
    When I tap the 'uniEats_Button1' button
    Then I expect the widget 'uniEats_page' to be present within 2 seconds

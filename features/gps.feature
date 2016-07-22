Feature: Verify correct behaviour from GPS sensor on mobile device, updating locations and retrieve correct values. External conditions should not affect stability of application

  @wip
  Scenario Outline: Fixed location testing updating on several coordinates
    Given Set virtual GPS on "<location>" with coordinates "<latitude>" and "<longitude>"
    When Query values from Geolocation
    Then It should retrieve same pre-fixed coordinates
    Examples:
      | location | latitude  | longitude |
      | home     | -34.82532 | -57.97322 |
      | coast    | -34.82060 | -57.96747 |
      #    | beach    |           |           |
      | home     | -34.82532 | -57.97322 |


  Scenario: Stress-test for update position on device in same place
    Given Set virtual GPS on "home" with coordinates "-34.82532" and "-57.97322"
    When Update position 5 times
    And Query values from Geolocation
    Then It should retrieve same pre-fixed coordinates


  Scenario Outline: Unexpected signal drop from virtual sensor
    Given Set virtual GPS on "<location>" with coordinates "<latitude>" and "<longitude>"
    When Query values from Geolocation
    Then It should retrieve same pre-fixed coordinates
    Examples:
      | location    | latitude  | longitude |
      | home        | -34.82532 | -57.97322 |
      | lost_signal |         0 |         0 |
      | lost_signal |         0 |         0 |
      | home        | -34.82532 | -57.97322 |


  Scenario: Unexpected momentary GPS disabled
    Given Set virtual GPS on "home" with coordinates "-34.82532" and "-57.97322"
    When The GPS sensor is set to disabled
    And Query values from Geolocation
    And The GPS sensor is set to enabled
    And Query values from Geolocation
    Then It should retrieve same pre-fixed coordinates


  Scenario: Unexpected GPS disabled by low battery
    Given Set virtual GPS on "home" with coordinates "-34.82532" and "-57.97322"
    When Battery power is set low
    And The GPS sensor is set to disabled
    Then It should retrieve zero values


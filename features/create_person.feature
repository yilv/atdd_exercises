Feature: CreatePerson

  Background:
    Given delete all people

  Scenario: Succeed in creating a person
    When create a person "Lv Yi", "Coach"
    Then see "created!"
    Then the person "Lv Yi", "Coach" exists

  Scenario: Succeed in creating two people
    Given create a person "Lv Yi", "Coach"
    And see "created!"
    When create a person "Zhang Liaoyuan", "Developer"
    Then see "created!"
    Then the person "Zhang Liaoyuan", "Developer" exists
    Then the person "Lv Yi", "Coach" exists

  Scenario: Succeed in creating people with same name
    Given create a person "Lv Yi", "Coach"
    And see "created!"
    When create a person "Lv Yi", "Developer"
    Then see "created!"
    Then the person "Lv Yi", "Coach" exists
    Then the person "Lv Yi.1", "Developer" exists
    
  Scenario Outline: Rules on name and title
    When create a person <Name>, <Title>
    Then see <Result>

  Examples:
    | Name                    | Title       | Result           |
    | "Lv Yi"                 | "Coach"     | "created!"       |
    | "Lv Yi"                 | "Developer" | "created!"       |
    | "Lv Yi"                 | ""          | "created!"       |
    | "20 Lv Yi"              | "Coach"     | "Invalid name!"  |
    | "Lv Yi 888888888888888" | "Coach"     | "Invalid name!"  |
    | ""                      | "Coach"     | "Invalid name!"  |
    | "Lv Yi"                 | "Engineer"  | "Invalid title!" |
  

Feature: adding verbs and conjugations
  As a ConjugQuiz admin
  I want to be able to add verbs and thier conjugations
  So visitors can have new quiz question.

  Scenario Outline: adding a verb
    When I add the verb "<verb>" with meaning "<meaning>"
    Then the verb should be available as a quiz question
    Examples:
      | verb      | meaning |
      | essere    | to be   |
      | sapere    | to know |

  Scenario Outline: adding conjugations
    When I add the conjugation for "<verb>" "<person>" "<number>" "<name>"
    Then the verb should be available as a quiz question
    Examples:
      | verb      | person | number   | name      |
      | essere    |  1st   | singular | sono      |
      | essere    |  2nd   | singular | sei       |
      | essere    |  3rd   | singular | e         |
      | essere    |  1st   | plural   | siamo     |
      | essere    |  2nd   | plural   | siete     |
      | essere    |  3rd   | plural   | hanno     |
      | sapere    |  1st   | singular | so        |
      | sapere    |  2nd   | singular | sai       |
      | sapere    |  3rd   | singular | sa        |
      | sapere    |  1st   | plural   | sappiamo  |
      | sapere    |  2nd   | plural   | sapete    |
      | sapere    |  3rd   | plural   | sanno     |

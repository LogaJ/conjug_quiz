Feature: adding conjugations
  As a ConjugQuiz admin
  I want to be able to add conjugations
  So I can test my knowlege level.

  Scenario Outline: adding a verb
    When I add the verb "<verb>" with meaning "<meaning>"
    Then the verb should be available as a quiz question
    Examples:
      | verb      | meaning |
      | essere    | to be   |
      | sapere    | to know |
      | avere     | to have |

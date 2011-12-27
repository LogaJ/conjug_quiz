Feature: adding conjugations
  As a ConjugQuiz admin
  I want to be able to add conjugations
  So I can test my knowlege level.

  Scenario Outline: adding conjugations for essere 
    When I add the conjugation for "<verb>" "<person>" "<number>" "<name>"
    Then the verb should be available as a quiz question

    Examples:
      | verb      | person | number   | name      |
      | essere    |  1st   | singular | sono      |
      | essere    |  2nd   | singular | sei       |
      | essere    |  3rd   | singular | e         |
      | essere    |  1st   | plural   | siamo     |
      | essere    |  2nd   | plural   | siete     |
      | essere    |  3rd   | plural   | sono      |

  Scenario Outline: adding conjugations for sapere 
    When I add the conjugation for "<verb>" "<person>" "<number>" "<name>"
    Then the verb should be available as a quiz question

    Examples:
      | verb      | person | number   | name      |
      | sapere    |  1st   | singular | so        |
      | sapere    |  2nd   | singular | sai       |
      | sapere    |  3rd   | singular | sa        |
      | sapere    |  1st   | plural   | sappiamo  |
      | sapere    |  2nd   | plural   | sapete    |
      | sapere    |  3rd   | plural   | sanno     |

  Scenario Outline: adding conjugations for avere
    When I add the conjugation for "<verb>" "<person>" "<number>" "<name>"
    Then the verb should be available as a quiz question

    Examples:
      | verb      | person | number   | name      |
      | avere     |  1st   | singular | ho        |
      | avere     |  2nd   | singular | hai       |
      | avere     |  3rd   | singular | ha        |
      | avere     |  1st   | plural   | abbiamo   |
      | avere     |  2nd   | plural   | avete     |
      | avere     |  3rd   | plural   | hanno     |

  Scenario Outline: adding conjugations for ??
    When I add the conjugation for "<verb>" "<person>" "<number>" "<name>"
    Then the verb should be available as a quiz question

    Examples:
      | verb      | person | number   | name      |
      | avere     |  1st   | singular | ho        |
      | avere     |  2nd   | singular | hai       |
      | avere     |  3rd   | singular | ha        |
      | avere     |  1st   | plural   | abbiamo   |
      | avere     |  2nd   | plural   | avete     |
      | avere     |  3rd   | plural   | hanno     |

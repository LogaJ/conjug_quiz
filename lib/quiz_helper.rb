def random_conjugations
  conjugations = Conjugation.all
  conjugations = conjugations.sample(10)

  generate_question_info_for conjugations
end

def generate_question_info_for conjugations
  info_for_all_questions = []

  conjugations.each do |conjugation|
    info_for_one_question = {:verb => Verb.get(conjugation.verb_id), :conjugation => conjugation}

    info_for_all_questions << info_for_one_question
  end

  quiz_questions info_for_all_questions
end

def quiz_questions info_for_all_questions

	info_for_all_questions.each do |question|
		questions = {}
	end

	display_questions
end

def display_questions
	binding.pry
end


def compare_correct_answers_with provided_answers
	user_answers = {}
	@final_score = 0

	provided_answers.each do |key, value|
		quiz_answer_id = key.gsub(/question_/, '')

		user_answers[quiz_answer_id] = value
	end
	quiz_question_results = []

	user_answers.each do |key, value|
		conjugation = Conjugation.get(key)

		if value.downcase.eql? conjugation.value.downcase
			quiz_question_results << "Correct: \"<font color=\"green\">#{value.downcase}</font>\" is the correct answer"

			@final_score += 1

		else
			quiz_question_results << "Incorrect: \"<font color=\"red\">#{value.downcase}</font>\" is the wrong answer, the answer should be: \"<font color=\"green\">#{conjugation.value.downcase}</font>\""
		end
	end

	return quiz_question_results
end

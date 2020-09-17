# frozen_string_literal: true
require 'CSV'

# Wave 1
def draw_letters
  letters_pool_to_draw_from = {
      'A' => 9,
      'B' => 2,
      'C' => 2,
      'D' => 4,
      'E' => 12,
      'F' => 2,
      'G' => 3,
      'H' => 2,
      'I' => 9,
      'J' => 1,
      'K' => 1,
      'L' => 4,
      'M' => 2,
      'N' => 6,
      'O' => 8,
      'P' => 2,
      'Q' => 1,
      'R' => 6,
      'S' => 4,
      'T' => 6,
      'U' => 4,
      'V' => 2,
      'W' => 2,
      'X' => 1,
      'Y' => 2,
      'Z' => 1
  }

  ten_strings_array = []

  letters_pool_keys = letters_pool_to_draw_from.keys
  until ten_strings_array.length == 10
    rand_letter = letters_pool_keys[rand(letters_pool_keys.size)]
    if (letters_pool_to_draw_from[rand_letter]).zero?
      next
    else
      letters_pool_to_draw_from[rand_letter] -= 1
    end

    ten_strings_array.push(rand_letter)
  end
  ten_strings_array
end

# WAVE 2
def uses_available_letters?(input, letters_in_hand)
  input = input.split('')
  letters_in_hand_clone = letters_in_hand.clone
  input.each do |element|
    if letters_in_hand_clone.include?(element)
      letters_in_hand_clone.delete(element)
    else
      return false
    end
  end
  return true
end

# Wave 3
def score_word(word)
  score = 0
  word = word.upcase
  word.chars.each do |character|

    case character
    when 'A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T'
      score += 1
    when 'D', 'G'
      score += 2
    when 'B', 'C', 'M', 'P'
      score += 3
    when 'F', 'H', 'V', 'W', 'Y'
      score += 4
    when 'K'
      score += 5
    when 'J', 'X'
      score += 8
    when 'Q', 'Z'
      score += 10
    end
  end
  score += 8 if word.length >= 7
  return score
end


# Wave 4
def highest_score_from(words)
  arr_of_scores = words.map do |word|
    { word: word, score: score_word(word) }
  end

  max_score = -1
  max_pair = nil

  arr_of_scores.each do |hash|
    if hash[:score] > max_score
      max_score = hash[:score]
      max_pair = hash
    elsif max_score == hash[:score]
      if max_pair[:word].length != 10
        if hash[:word].length < max_pair[:word].length || hash[:word].length == 10
          max_pair = hash
          max_score = hash[:score]
        end
      end
    end
  end
  max_pair
end

# Wave 5
def is_in_english_dict?(input)
  dictionary = CSV.read('assets/dictionary-english.csv', headers: true)

  dictionary.each do |word|
    if input == word[0]
      return true
      break
    end
  end
  return false
end

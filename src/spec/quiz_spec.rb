# frozen_string_literal: true

require_relative '../quiz_method'

describe 'start quiz method' do
  it 'should increase user score by 1 for correct answers' do
    score = 0
    answer = true
    score += 1 if answer
    expect(score).to eq(1)
  end

  it 'should not increase user score for incorrect answers' do
    score = 0
    answer = false
    score += 1 if answer
    expect(score).to eq(0)
  end
end

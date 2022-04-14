require_relative '../quiz_method.rb'

describe "start quiz method"  do
    it 'should increase user score by 1 for correct answers' do
    score = 0
    answer = true
    if answer
        score += 1
    end
    expect(score).to eq(1)
    end

    it 'should not increase user score for incorrect answers' do
    score = 0
    answer = false
    if answer
        score += 1
    end
    expect(score).to eq(0)
    end

end
require 'rails_helper'

RSpec.describe Commit, :type => :model do
  describe '#title' do
    let(:commit) { Commit.new(message: "A title\n\nA description.") }

    it 'returns message until first \n' do
      expect(commit.title).to eq('A title')
    end
  end
end

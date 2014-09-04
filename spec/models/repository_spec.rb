require 'rails_helper'

RSpec.describe Repository, :type => :model do
  describe '::find_or_create_by_full_name' do
    context 'with repository' do
      let!(:repository) { Repository.create(full_name: 'test/repo') }

      it 'returns repository' do
        expect(Repository.find_or_create_by_full_name('test/repo')).to eq(repository)
      end
    end

    context 'without repository' do
      it 'creates a new repository' do
        expect {
          Repository.find_or_create_by_full_name('test/repo')
        }.to change { Repository.count }.by(1)
      end
    end
  end
end

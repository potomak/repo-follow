require 'rails_helper'

RSpec.describe "repositories/show", :type => :view do
  let(:current_user) { instance_double('User') }

  before(:each) do
    @repository = assign(:repository, Repository.create!(
      :full_name => "test/repo"
    ))

    allow(view).to receive(:current_user).and_return(current_user)
  end

  it "renders attributes" do
    allow(current_user).to receive(:follows).with(@repository)
    render
    expect(rendered).to match(/test\/repo/)
  end
end

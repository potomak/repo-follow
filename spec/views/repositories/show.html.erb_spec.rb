require 'rails_helper'

RSpec.describe "repositories/show", :type => :view do
  before(:each) do
    @repository = assign(:repository, Repository.create!(
      :full_name => "Full Name"
    ))
  end

  it "renders attributes" do
    render
    expect(rendered).to match(/Full Name/)
  end
end

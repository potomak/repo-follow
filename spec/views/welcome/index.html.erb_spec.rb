require 'rails_helper'

RSpec.describe "welcome/index.html.erb", :type => :view do
  it "renders description" do
    render
    expect(rendered).to match(/Follow your favorite GitHub repositories/)
  end
end

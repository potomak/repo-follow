require 'rails_helper'

RSpec.describe "welcome/index.html.erb", :type => :view do
  let(:current_user) { instance_double('User') }

  context "without current user" do
    before { allow(view).to receive(:current_user) }

    it "renders description" do
      render
      expect(rendered).to match(/Follow your favorite GitHub repositories/)
    end
  end
end

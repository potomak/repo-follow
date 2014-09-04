require 'rails_helper'

RSpec.describe "commits/show", :type => :view do
  before(:each) do
    @commit = assign(:commit, Commit.create!(
      :sha => "Sha",
      :message => "MyText",
      :author => "Author",
      :author_image => "Author Image",
      :committer => "Committer",
      :committer_image => "Committer Image",
      :repository => nil
    ))
  end

  it "renders attributes" do
    render
    expect(rendered).to match(/Sha/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Author/)
    expect(rendered).to match(/Author Image/)
    expect(rendered).to match(/Committer/)
    expect(rendered).to match(/Committer Image/)
    expect(rendered).to match(//)
  end
end

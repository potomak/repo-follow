class CommitsController < ApplicationController
  def show
    @commit = Commit.find_or_create_by_sha(params[:id])
  end
end

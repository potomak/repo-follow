class CommitsController < ApplicationController
  def show
    @commit = Commit.find_by_sha!(params[:id])
  end
end

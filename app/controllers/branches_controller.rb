class BranchesController < ApplicationController
  before_action :find_branch

  def follow
    @branch.users << current_user
    @branch.fetch_and_update_or_create_commits(current_user.github_client)
    redirect_to @repository, notice: "You're following #{@branch.name} repo"
  end

  def unfollow
    @branch.users.delete(current_user)
    redirect_to @repository, notice: "You're not following #{@branch.name} repo anymore"
  end

  private

  def find_branch
    @repository = Repository.find_by_full_name!(params[:repository_id])
    @branch = @repository.branches.find_by_name!(params[:id])
  end
end

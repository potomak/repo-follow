class RepositoriesController < ApplicationController
  before_action :find_repository, except: :show

  def show
    @repository = Repository.find_and_update_or_create_by_full_name(current_user.github_client, params[:id])
  end

  def follow
    @repository.users << current_user
    redirect_to @repository, notice: 'You\'re following this repo'
  end

  def unfollow
    @repository.users.delete(current_user)
    redirect_to @repository, notice: 'You\'re not following this repo anymore'
  end

  private

  def find_repository
    @repository = Repository.find_by_full_name!(params[:id])
  end
end

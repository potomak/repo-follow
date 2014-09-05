class RepositoriesController < ApplicationController
  def show
    @repository = Repository.find_and_update_or_create_by_full_name(current_user.github_client, params[:id])
  end
end

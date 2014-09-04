class RepositoriesController < ApplicationController
  def show
    @repository = Repository.find_or_create_by_full_name(params[:id])
  end
end

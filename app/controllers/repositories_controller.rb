class RepositoriesController < ApplicationController
  def show
    @repository = Repository.find_by_full_name!(params[:id])
  end
end

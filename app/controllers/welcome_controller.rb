class WelcomeController < ApplicationController
  skip_before_action :deny_unauthorized!

  def index
    if current_user
      @commits = current_user.commits.includes(:repository).order('date DESC')
    end
  end
end

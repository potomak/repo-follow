class WelcomeController < ApplicationController
  skip_before_action :deny_unauthorized!

  def index
  end
end

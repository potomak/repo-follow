class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  skip_before_action :deny_unauthorized!, except: :destroy

  def new
    redirect_to "/auth/#{params[:provider]}"
  end

  def create
    @current_user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = @current_user.id

    redirect_to root_url, notice: 'Signed in!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Signed out!'
  end

  def failure
    redirect_to root_url, alert: "Authentication error: #{params[:message].try(:humanize)}"
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end

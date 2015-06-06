class ApplicationController < ActionController::Base
  protect_from_forgery


  def login
  	redirect_to root_path
  end

  def signup
  	redirect_to root_path
  end
end

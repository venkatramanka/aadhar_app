class UsersController < ApplicationController
  def signup
  	@user = User.new
  end

  def index
  end
end

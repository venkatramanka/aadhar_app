class UsersController < ApplicationController
  def show
  	@user = User.find params[:id]
  	render :text => "Hello #{@user.name}"
  end

  def index
  end
end

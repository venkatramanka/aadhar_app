class UsersController < ApplicationController
  def show
  	@user = User.find params[:id]
  end

  def index
  end

  def update
    begin
      if user = User.find_by_id(params[:id])
        user.update_attributes params[:user]
        user.save!
        flash[:success] = "Updated Successfully"
      end
    rescue Exception => e
      flash[:error] = e.message
    end
    redirect_to user_path
  end
end

class StoreController < ApplicationController
  def show
  	@store = Store.find params[:id]
  end

  def index
  end

  def payment

  end

  def update
    begin
      if store = Store.find_by_id(params[:id])
        store.update_attributes params[:user]
        store.save!
        flash[:success] = "Updated Successfully"
      end
    rescue Exception => e
      flash[:error] = e.message
    end
    redirect_to store_path
  end
end

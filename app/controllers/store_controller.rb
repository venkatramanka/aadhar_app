class StoreController < ApplicationController


  def show
  	@store = Store.find params[:id]
    set_warning
  end

  def index
  end

  def payment

  end

  def update
    begin
      if store = Store.find_by_id(params[:id])
        store.update_attributes params[:store]
        store.save!
        flash[:success] = "Updated Successfully"
      end
    rescue Exception => e
      flash[:error] = e.message
    end
    redirect_to store_path
  end

  def set_warning
    if @store.attributes.values.include?(nil)
      @message = "Please complete your profile for admin to Verify"
      @class = "alert alert-warning"
    elsif !@store.verified
      @message = "Admin is yet to verify your profile"
      @class = "alert alert-info"
    end
  end

end

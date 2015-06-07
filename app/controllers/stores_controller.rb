class StoresController < ApplicationController
  before_filter :authenticate_store!, except: [:store_signup]

  def show
  	@store = Store.find params[:id]
    set_warning
  end

  def index
  end

  def payment
    debugger
    if params[:store]
      user = User.find_by_aadhar_number(params["store"]["hidden_aadhaar_number"])
      if user.nil?
        @message = "Transfer failed. No Account found for user !"
        @class = "alert alert-danger"
      else
        response = verify_otp({"aadhaar_number" => params["store"]["hidden_aadhaar_number"],
        "otp" => params["store"]["otp"],
        "pincode" => params["store"]["pincode"]})
        if response
          total_amount = params["store"]["amount"].to_i
          if user.wallet.balance < total_amount
            @message = "Insufficient funds !"
            @class = "alert alert-warning"
          else
            tax_amount = current_store.transfer_amount(user,total_amount)
            StoreTransaction.create({:amount => total_amount,
              :user_id => user.id,
              :store_id => current_store.id,
              :tax => tax_amount,
              :remarks => params["store"]["remarks"]
            })
            @message = "Amount transferred Successfully !"
            @class = "alert alert-success"
          end
        else
          @message = "Authentication Failed. Please try again"
          @class = "alert alert-danger"
        end
      end
    end
  end

  def store_signup
    details = { :name => params["store"]["name"],
      :email => params["store"]["email"],
      :password => Digest::MD5.hexdigest(params["store"]["password"]),
      :encrypted_password => User.new(:password => params["store"]["password"]).encrypted_password,
      :verified => false
    }
    @store = Store.create(details)
    Wallet.create(:owner_id => @store.id, :balance => 0) if @store.id
    sign_in(@store)
    redirect_to "/store/#{@store.id}"
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
    if current_store.profile_incomplete?
      @message = "Please complete your profile for admin to Verify"
      @class = "alert alert-warning"
    elsif !@store.verified
      @message = "Admin is yet to verify your profile"
      @class = "alert alert-info"
    end
  end

end

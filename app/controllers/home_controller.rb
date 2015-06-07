class HomeController < ApplicationController
  def index
  end

  def transfer

  end

  def transaction
  	agent = Mechanize.new
    aadhaar_number = params["transaction"]["from"]
    otp = params["transaction"]["otp"]
    pincode = params["transaction"]["pincode"]
    remarks = params["transaction"]["remarks"]
    to = params["transaction"]["to"]
    amount = params["transaction"]["amount"]
    response = agent.post("https://ac.khoslalabs.com/hackgate/hackathon/kyc/raw",{"consent" => "Y", "auth-capture-request" => {"aadhaar-id" => aadhaar_number,"modality" => "otp","otp" => otp,"certificate-type" => "preprod","device-id" => "public","location" => {"type" => "pincode","pincode" => pincode}}}.to_json,{'Content-Type' => 'application/json'})
  	if response && JSON.parse(response.body)["success"] == true
  		@from = User.find_by_aadhar_number(aadhaar_number)
  		@to = User.find_by_aadhar_number(to)
  		if @from.nil? || @to.nil?
  			@status = 'User Account not found'
  			@class = 'warning'
  		elsif(@from.wallet.balance < amount)
  			@status = 'Insufficiant funds'
  			@class = 'danger'
  		else
  			UserTransaction.create(:amount => amount, :user_id => aadhaar_number, :to_user_id => to, :remarks => remarks)
  			@status = 'Transfer complete'
  			@class = 'success'
  			@from.wallet.update_attribute(:balance => @from.wallet.balance - amount)
  			@to.wallet.update_attribute(:balance => @from.wallet.balance + amount)
  		end
  	else
  		@status = 'Something went wrong. Try again later.'
  		@class = 'danger'
  	end

  end
end

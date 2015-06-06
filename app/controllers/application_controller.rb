class ApplicationController < ActionController::Base
  protect_from_forgery


  def login
  	@user = User.find_by_aadhar_number(params["user"]["login_aadhaar_number"])
    if @user.present? && @user.password == params["user"]["password"] 
      redirect_to "/user/#{@user.id}"
    else
      redirect_to :back
    end
  end

  def signup
  	agent = Mechanize.new
  	aadhaar_number = params["user"]["hidden_aadhaar_number"]
  	otp = params["user"]["otp"]
  	pincode = params["user"]["pincode"]
  	password = params["user"]["password"]
  	response = agent.post("https://ac.khoslalabs.com/hackgate/hackathon/kyc/raw",{"consent" => "Y", "auth-capture-request" => {"aadhaar-id" => aadhaar_number,"modality" => "otp","otp" => otp,"certificate-type" => "preprod","device-id" => "public","location" => {"type" => "pincode","pincode" => pincode}}}.to_json,{'Content-Type' => 'application/json'})
  	details = Hash.new
  	if response
  		res = JSON.parse(response.body)["kyc"]
  		details = {:aadhar_number => aadhaar_number,
  		  :name => res['poi']['name'],
  		  :dob => res['poi']['dob'],
  		  :email => '',
  		  :gender => res['poi']['gender'],
  		  :mobile_number => '',
  		  :password => password,
  		  :address => "#{res['poa']['house']},#{res['poa']['street']},#{res['poa']['lm']},#{res['poa']['po']},
  		  #{res['poa']['vtc']},#{res['poa']['subdist']},#{res['poa']['dist']},#{res['poa']['state']},#{res['poa']['pc']}."
  		}
  		@user = User.create(details)
      Wallet.create(:owner_id => @user.id, :type => 'individual', :balance => 0) if @user
  	end
  	redirect_to "/user/#{@user.id}"
  end

  def dispatch_otp
  	agent = Mechanize.new
  	x = agent.post("https://ac.khoslalabs.com/hackgate/hackathon/otp",
  		{"aadhaar-id" => params["user"]["aadhaar_number"],
  			"channel" => "SMS",
  			"location" => {"type" => "pincode", "pincode" => "666666" }}.to_json,
  			{'Content-Type' => 'application/json'})
  	render :nothing => true
  end
end

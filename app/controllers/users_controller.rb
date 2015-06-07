class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:login, :signup]

  def login
    @user = User.find_by_aadhar_number(params["user"]["login_aadhaar_number"])
    pass = params["user"]["password"]
    if @user.present? && @user.valid_password?(pass)
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
    debugger
    if response
      res = JSON.parse(response.body)["kyc"]
      details = {:aadhar_number => aadhaar_number,
        :name => res['poi']['name'],
        :dob => res['poi']['dob'],
        :email => 'notgiven@email.com',
        :gender => res['poi']['gender'],
        :mobile_number => '',
        :password => Digest::MD5.hexdigest(password),
        :encrypted_password => User.new(:password => password).encrypted_password,
        :address => "#{res['poa']['house']},#{res['poa']['street']},#{res['poa']['lm']},#{res['poa']['po']},
        #{res['poa']['vtc']},#{res['poa']['subdist']},#{res['poa']['dist']},#{res['poa']['state']},#{res['poa']['pc']}."
      }
      @user = User.create(details)
      @user.password = password
      Wallet.create(:owner_id => @user.id, :type => 'individual', :balance => 0) if @user
    end
    redirect_to "/user/#{@user.id}"
  end

  def show
  	@user = User.find params[:id]
    @banks = File.open("#{Rails.root}/banks.txt","r").read.split(",")
  end

  def index
  end

  def form
    @user = User.find params[:id]
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

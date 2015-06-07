class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    session["resource_return_to"] = redirect_user(resource)
  end

  def redirect_user(resource)
    resource.is_a?(User) ? "/user/#{resource.id}" : "/store/#{resource.id}"
  end

  def dispatch_otp_transfer
    send_otp(params["user"]["aadhaar_number"])
    render :nothing => true
  end

  def dispatch_otp_create
    send_otp(params["user"]["aadhaar_number"])
  	render :nothing => true
  end

  def send_otp(aadhaar_number)
    agent = Mechanize.new
    x = agent.post("https://ac.khoslalabs.com/hackgate/hackathon/otp",
      {"aadhaar-id" => aadhaar_number,
        "channel" => "SMS",
        "location" => {"type" => "pincode", "pincode" => "666666" }}.to_json,
        {'Content-Type' => 'application/json'})
  end

  def verify_otp(hash)
    agent = Mechanize.new
    agent.post("https://ac.khoslalabs.com/hackgate/hackathon/kyc/raw",{"consent" => "Y",
      "auth-capture-request" => {"aadhaar-id" => hash["aadhaar_number"],
          "modality" => "otp","otp" => hash["otp"],
          "certificate-type" => "preprod",
          "device-id" => "public",
          "location" => {"type" => "pincode","pincode" => hash["pincode"]}
        }
      }.to_json,{'Content-Type' => 'application/json'})
  end

end

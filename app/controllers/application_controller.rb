class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    session["resource_return_to"] = redirect_user(resource)
  end

  def redirect_user(resource)
    resource.is_a?(User) ? "/user/#{resource.id}" : "/store/#{resource.id}"
  end

  def store_signup
    details = { :name => params["store"]["name"],
      :email => params["store"]["email"],
      :password => Digest::MD5.hexdigest(params["store"]["password"])
    }
    @store = Store.create(details)
    redirect_to "/store/#{@store.id}"
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

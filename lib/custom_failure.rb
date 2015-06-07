class CustomFailure < Devise::FailureApp
  def redirect_url
    flash[:error] = true
    root_path
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token
  protect_from_forgery
  skip_forgery_protection

  def google_oauth2
    # binding.irb
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(auth)

    puts "\n\n\n\n"
    puts "user - #{@user}"
    puts "req - #{request}"
    puts "\n\n\n\n"

    if @user.persisted?
      session[:user_token] = auth.credentials.token
      session[:user_email] = auth.info.email
      sign_in @user
      respond_to do |format|
        format.json { render json: UserSerializer.render(resource, root: :user, view: :private_info), status: :ok }
      end
    else
      respond_to do |format|
        format.json { render json: @user.errors.full_messages.join("\n"), status: :bad_request }
      end
    end
  end

  # TODO: Add other providers here! Apple, Github, etc
end

class ApplicationController < ActionController::API
  # skip_before_action :verify_authenticity_token
  # protect_from_forgery with: :exception
  # protect_from_forgery
  include ActionController::RequestForgeryProtection
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, Mongoid::Errors::DocumentNotFound, with: :not_found_error
  rescue_from ActionController::InvalidAuthenticityToken, with: :redirect_and_prompt_for_sign_in

  private

  def redirect_and_prompt_for_sign_in
    redirect_to(new_user_session_path, alert: "Please sign in.")
  end

  def not_found_error
    error_entities = []

    params.each { |k, v| error_entities << ({k => v, "entity" => k.delete("_id")}) if k.include?("_id") }

    render json: {
      error: "Not found",
      entities: error_entities
    }, status: 404
  end
end

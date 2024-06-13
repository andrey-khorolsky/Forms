class ApplicationController < ActionController::API
  include ActionPolicy::Controller
  authorize :user, through: :current_user

  rescue_from ActionPolicy::Unauthorized, with: :forbidden
  rescue_from ActiveRecord::RecordNotFound, Mongoid::Errors::DocumentNotFound, with: :not_found_error
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end

  private

  def not_found_error
    error_entities = []

    params.each { |k, v| error_entities << ({k => v, "entity" => k.delete("_id")}) if k.include?("_id") }

    render json: {
      message: "Not found",
      entities: error_entities
    }, status: 404
  end

  def forbidden
    render json: {
      message: "Not enough access"
    }, status: 403
  end

  def unprocessable_entity
    render json: {
      message: "Unprocessable entity"
    }, status: 422
  end
end

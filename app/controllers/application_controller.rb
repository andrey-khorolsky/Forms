class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, Mongoid::Errors::DocumentNotFound, with: :not_found_error
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
      error: "Not found",
      entities: error_entities
    }, status: 404
  end
end

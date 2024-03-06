class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, Mongoid::Errors::DocumentNotFound, with: :not_found_error

  private

  def not_found_error
    render json: {
      error: "Not found",
      id: params[:id],
      entity: params[:controller].singularize.capitalize
    }, status: 404
  end
end

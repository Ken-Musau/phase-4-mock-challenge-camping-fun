class SignupsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def create
    render json: Signup.create!(signup_params), status: :created
  end

  private

  def signup_params
    params.permit(:time, :camper_id, :activity_id)
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end

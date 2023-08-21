class CampersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def index
    render json: Camper.all
  end

  def show
    camper = Camper.find(params[:id])
    render json: camper, status: :ok
  end

  def create
    render json: Camper.create!(camper_params), status: :created
  end

  private

  def render_not_found_response
    render json: { error: "Camper not found" }
  end

  def camper_params
    params.permit(:name, :age)
  end

  def render_unprocessable_entity(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end

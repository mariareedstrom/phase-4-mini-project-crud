class SpicesController < ApplicationController

  def index
    render json: Spice.all, status: :ok
  end

  def show
    spice = find_spice
    render json: spice
  rescue ActiveRecord::RecordNotFound
    render_not_found_response
  end

  def create
    spice = Spice.create(spice_params)
    render json: spice, status: :created
  end

  def update
    spice = find_spice
    spice.update(spice_params)
    render json: spice
  rescue ActiveRecord::RecordNotFound
    render_not_found_response
  end

  def destroy
    spice = find_spice
    spice.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render_not_found_response
  end

  private

  def find_spice
    Spice.find_by(id: params[:id])
  end

  def render_not_found_response
    render json: {error: "spice not found"}, status: :not_found
  end

  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end

end

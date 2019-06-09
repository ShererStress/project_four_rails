class PlanesController < ApplicationController
  # index route
  def index
    render json: Plane.all
  end

  # show route
  def show
    render json: Plane.find(params["id"])
  end

  # create route
  def create
    render json: Plane.create(params["plane"])
  end

  # delete route
  def delete
    render json: Plane.delete(params["id"])
  end

end

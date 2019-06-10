class PlanesController < ApplicationController

  # GET: index route
  def index
    render json: Plane.all
  end

  # GET: show route
  def show
    render json: Plane.find(params["id"])
  end

  # POST: create route
  def create
    render json: Plane.create(params["plane"])
  end

  # DELETE: delete route
  def delete
    render json: Plane.delete(params["id"])
  end

end

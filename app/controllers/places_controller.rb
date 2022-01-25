class PlacesController < ApplicationController
  def index
    @place = Place.new
    @places = Place.all
  end

  def edit
    @place = Place.find(params[:id])
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      redirect_to places_path
    else
      @places = Place.all.page(params[:page]).per(10)
      render :index and return
    end
  end

  def update
    @place = Place.find(params[:id])
    if @place.update(place_params)
      redirect_to places_path
    end
  end
  
  def place_params
    params.require(:place).permit(:name, :is_valid)
  end
  
end

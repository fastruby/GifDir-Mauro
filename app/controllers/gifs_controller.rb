# frozen_string_literal: true

class GifsController < ApplicationController
  def index
    @gifs = Gif.all
  end

  def show
    @gif = Gif.find(params[:id])
  end

  def new
    @gif = Gif.new
  end

  def create
    @gif = Gif.new(gif_params)
    if @gif.save
      flash[:notice] = 'Succesfully created gif'
      redirect_to gif_path(@gif)
    else
      render action: :new
    end
  end

  private

  def gif_params
    params.require(:gif).permit(:name, :img)
  end
end

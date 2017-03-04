class UploadsController < ApplicationController
  def new
    @u = Upload.new description: 'Default'
  end

  def create
    upar = params[:upload]
    u = Upload.new description: upar[:description]
    u.save
    redirect_to uploads_path
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
    u = Upload.find(params[:id])   rescue nil
    if u
       u.destroy
       redirect_to uploads_path, notice: "Successfully deleted upload id=#{params[:id]}"
    else
       redirect_to uploads_path, alert: "Unable to delete upload id=#{params[:id]}"
    end
  end

  def index
    @uploads = Upload.all
  end
end

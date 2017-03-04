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

  def delete
  end

  def index
    @uploads = Upload.all
  end
end

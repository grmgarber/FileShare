class UploadsController < ApplicationController

  def new
    @u = Upload.new
  end

  def create
    @u = Upload.new
    @u.attributes = upload_params
    @u.user = current_user
    if@u.save
      redirect_to uploads_path, notice: 'Upload created successfully'
    else
      render 'new'
    end
  end

  def edit
    @u = Upload.find(params[:id])
  end

  def update
    @u = Upload.find(params[:id])   rescue nil
    @u.description =  upload_params[:description]
    if @u.save
      redirect_to uploads_path, notice: 'Upload updated successfully'
    else
      flash.now[:alert] = GENERIC_FORM_ERROR_FLASH
      render 'edit'
    end
  end

  def show
    @u = Upload.find(params[:id])
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
    @uploads = Upload.where(user: current_user)
  end

  private

  def upload_params
    params.require(:upload).permit(:upl_file, :description)
  end
end

# UploadsController class
class UploadsController < ApplicationController
  respond_to :html, :js

  # GET /uploads/new
  def new
    @u = Upload.new
  end

  # POST /uploads
  def create
    @u = Upload.new
    @u.attributes = upload_params
    @u.user = current_user
    if @u.save
      redirect_to uploads_path, notice: 'Upload created successfully'
    else
      render 'new'
    end
  end

  # GET /uploads/id
  def edit
    @u = Upload.find(params[:id])
    @new_grant = Grant.new(upload: @u)
  end

  # UploadsController#update demonstrates the new Rails4 way,
  # with Unobtrusive JavaScript (form remote: true triggering AJAX)
  def update
    @u = Upload.find(params[:id])   rescue nil
    @u.description =  upload_params[:description]
    respond_to do |format|
      if @u.save
        format.js
        format.html do
          redirect_to edit_upload_path(@u.id),
            notice: 'Description updated successfully'
        end
      else
        format.js
        format.html do
          flash.now[:alert] = GENERIC_FORM_ERROR_FLASH
          render 'edit'
        end
      end
    end
  end

  # GET /uploads/id
  def show
    @u = Upload.find(params[:id])
  end

  # DELETE /uploads/id
  def destroy
    u = Upload.find(params[:id])   rescue nil
    if u
      u.destroy
      redirect_to uploads_path,
                  notice: "Successfully deleted upload id=#{params[:id]}"
    else
      redirect_to uploads_path,
                  alert: "Unable to delete upload id=#{params[:id]}"
    end
  end

  # GET /uploads
  def index
    @uploads = Upload.all_viewable_by(current_user)
  end

  # This method will return emails of users who can be added to the list of
  # viewers of the current upload. jQuery UI passes a :term parameter with
  # N letters typed into the auto-complete field
  def potential_grantees
    render json: User.potential_grantee_emails(
        current_user.id, params[:id], term: params['term'])
  end

  private

  # protect against mass assignment abuse
  def upload_params
    params.require(:upload).permit(:upl_file, :description)
  end
end

# upload_grants_path	POST	/uploads/:upload_id/grants(.:format)	grants#create
# upload_grant_path	DELETE	/uploads/:upload_id/grants/:id(.:format)	grants#destroy

class GrantsController < ApplicationController

  before_action :set_tab_number
  def create
    g = Grant.new(upload_id: params[:upload_id])
    user = User.where(email: params[:email]).limit(1).try(:first)
    message = 'You do not need readonly access to your own files'  if user.id == current_user.id
    g.user = user
    if user && user.id != current_user.id && g.save
      g.user = user
      if request.xhr?
        @u = Upload.find(params[:upload_id])
        @new_grant = Grant.new(upload_id: params[:upload_id])
        render 'create', layout: false
      else
        redirect_to edit_upload_path(params[:upload_id]), notice: "User #{user.email} given permission to view the upload"
      end
      return
    end
    if user
      message ||= g.errors.full_messages.join("; ")
    else
      message = "User account for #{params[:email]} not found"
    end
    if request.xhr?
      render json: {error: message}
    else
      redirect_to edit_upload_path(params[:upload_id]), alert: message
    end
  end

  def destroy
    res = Grant.delete(params[:id])
    if request.xhr?
      render nothing: true
      return
    end
    redirect_to edit_upload_path(params[:upload_id]),
                alert: (res == 1 ? 'Viewer removed successfully' : 'Failed to remove viewer')

  end

  def set_tab_number
    flash[:accordion_tab_number] = "1"
  end
end

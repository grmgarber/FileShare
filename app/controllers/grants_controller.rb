# upload_grants_path	POST	/uploads/:upload_id/grants(.:format)	grants#create
# upload_grant_path	DELETE	/uploads/:upload_id/grants/:id(.:format)	grants#destroy

class GrantsController < ApplicationController

  before_action :set_tab_number
  def create
    g = Grant.new(upload_id: params[:upload_id])
    user = User.where(email: params[:email]).limit(1).try(:first)
    g.user = user
    if g.save
      redirect_to edit_upload_path(params[:upload_id]), notice: "User #{user.email} given permission to view the upload"
      return
    end
    redirect_to edit_upload_path(params[:upload_id]),
        alert: (user ? "Unable to permit #{params[:email]} viewing this upload" : "User #{params[:email]} not found")
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

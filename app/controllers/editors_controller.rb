class EditorsController < Devise::RegistrationsController
  before_filter :check_permissions, :only => [:new, :create, :cancel]
  skip_before_filter :require_no_authentication

  def dashboard
    render "editors/dashboard.html.haml"
  end

  def index
    @editors = Editor.all
    respond_to do |format|
      format.html
    end
  end

  # def new
  #   redirect_to editor_registration_path
  # end

  # def create
  #   respond_to do |format|
  #     if @brand.save
  #       format.html { redirect_to manage_brands_path, notice: 'Brand was successfully created.' }
  #     else
  #       format.html { render action: "new" }
  #     end
  #   end
  # end

  def destroy
    @editor = Editor.find(params[:id])
    @editor.destroy
    redirect_to admin_editors_path
  end

  private
    def check_permissions
      authorize! :create, resource
    end
end

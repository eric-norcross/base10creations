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

  def new
    @resource = Editor.new
    render 'editor/new'
  end

  def create
    @editor = Editor.new(params[:editor])

    respond_to do |format|
      if @editor.save
        format.html { redirect_to admin_editors_path, notice: 'Editor was successfully created.' }
      else
        format.html { render new_editor_path }
      end
    end
  end

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
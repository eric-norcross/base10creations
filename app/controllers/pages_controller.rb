class PagesController < ApplicationController
  authorize_resource
  skip_authorize_resource :only => [:home, :show]

  def home
    @page = Page.find_by_title("Home");
    render "layouts/skins/home"
  end 

  # Admin Routes
  def manage
    @pages = Page.all
    respond_to do |format|
      format.html
    end
  end

  # REST Routes
  # def index
  #   @pages = Page.all
  #   respond_to do |format|
  #     format.html  
  #   end
  # end

  def show
    @page = Page.find(params[:id])

    Rails.logger.debug "@page: #{@page.inspect}"
    Rails.logger.debug "@page.skin: #{@page.skin.inspect}"
    Rails.logger.debug "@page.skin.template: #{@page.skin.template}"

    render @page.skin.template
  end

  def new
    @page = Page.new

    # 1.times { 
    #   carousel = @page.carousels.build 
    #   3.times do
    #     figure = carousel.figures.build
    #     figure.images.build
    #   end
    # }

    # 3.times do
    #   figures = @page.figures.build
    #   figures.images.build
    # end

    respond_to do |format|
      format.html
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to pages_path, notice: 'Page was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to pages_path, notice: 'Page was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_path }
    end
  end
end

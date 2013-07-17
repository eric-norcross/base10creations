class StylesController < ApplicationController
  def index
    @styles = Style.all

    respond_to do |format|
      format.html # index.html.erb
      # format.json { render json: @styles }
    end
  end

  def show
    @products = Style.products(params)
    
    render "pages/templates/list"
  end

  def new
    @style = Style.new

    respond_to do |format|
      format.html # new.html.erb
      # format.json { render json: @style }
    end
  end

  def edit
    @style = Style.find(params[:id])
  end

  def create
    @style = Style.new(params[:style])

    respond_to do |format|
      if @style.save
        format.html { redirect_to styles_url, notice: 'Style was successfully created.' }
        # format.json { render json: @style, status: :created, location: @style }
      else
        format.html { render action: "new" }
        # format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @style = Style.find(params[:id])

    respond_to do |format|
      if @style.update_attributes(params[:style])
        format.html { redirect_to styles_url, notice: 'Style was successfully updated.' }
        # format.json { head :no_content }
      else
        format.html { render action: "edit" }
        # format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @style = Style.find(params[:id])
    @style.destroy

    respond_to do |format|
      format.html { redirect_to styles_url }
      # format.json { head :no_content }
    end
  end
end

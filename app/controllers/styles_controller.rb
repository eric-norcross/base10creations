class StylesController < ApplicationController
  def index
    @styles = Style.all

    respond_to do |format|
      format.html # index.html.erb
      # format.json { render json: @styles }
    end
  end

  # def show
  #   @style = Style.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     # format.json { render json: @style }
  #   end
  # end

  def new
    @style = Style.new

    respond_to do |format|
      format.html # new.html.erb
      # format.json { render json: @style }
    end
  end

  def show
    # @component = Component.find(params[:id])
    # @collection_styles = CollectionStyle.where(:style_id => params[:id])
    @collection_styles = CollectionStyle.where(:style_id => params[:id])
    @collection_styles = @collection_styles.map{|collection_style| collection_style.collection_id}

    # Model.find(id_or_array_of_ids, options_hash)
    # @products = Product.find_by_collection_id(@collection_styles)

    # Client.all(:conditions => { :orders_count => [1,3,5] })
    @products = Product.all(:conditions => { :collection_id => @collection_styles })
    
    # User.find_each do |user| NewsLetter.weekly_deliver(user) end


    STDOUT << "collection_styles.length: #{@collection_styles.length}; "
    STDOUT << "products.length: #{@products.length}; "


    render "pages/templates/list"
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

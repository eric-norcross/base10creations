class ComponentsController < ApplicationController
  def index
    @components = Component.all

    respond_to do |format|
      format.html # index.html.erb
      # format.json { render json: @components }
    end
  end

  def show
    # Get Component 
    @component = Component.find(params[:id])

    # Set up side nav
    @side_nav_elements = @component.siblings

    # If a Component has sub-components, replace the Component id with the Sub-Component ids
    # This is done because if the user selects "Desks" the results will include all Products/Compilations that are associated with any Sub-Component of "Desks"
    @component_ids = [@component.id]
    if !@component.children.blank?
      @component_ids = @component.children.map{ |component| component.id }
    end

    # Get all Products based on the Components/Sub-Components [Optimize by selected product_id's only]
    @product_ids = ProductCompilationComponent.where(:component_id => @component_ids).map{ |product_compilation_component| product_compilation_component.product_id }
    @products = Product.where(:id => @product_ids)

    # Create an array of Skus where the Sku belongs to a Compilation
    # Also create an array of Products not to include if their skus belong to a Compilation
    # @compilation_products = []
    @compilation_ids = []
    @products.each do |product|
      product.skus.each do |sku|
        if sku.compilation_id
          # @compilation_products.push(product) unless @compilation_products.include?(product)
          @compilation_ids.push(sku.compilation_id) unless @compilation_ids.include?(sku.compilation_id)
        end
      end
    end

    # Get Compilations where the Product of the Sku had one of the Components assigned
    # @compilation_ids = @compilation_skus.map{ |compilation_sku| compilation_sku.compilation_id}
    @compilations = Compilation.where(:id => @compilation_ids)

    # Combine the Products and Compilations
    # @products = ((@products - @compilation_products) + @compilations).sort_by(&:name)
    @products = (@products + @compilations).sort_by(&:name)


    render "layouts/templates/list"
  end

  def new
    @component = Component.new

    respond_to do |format|
      format.html # new.html.erb
      # format.json { render json: @component }
    end
  end

  def edit
    @component = Component.find(params[:id])
  end

  def create
    @component = Component.new(params[:component])

    respond_to do |format|
      if @component.save
        format.html { redirect_to components_url, notice: 'Component was successfully created.' }
        # format.json { render json: @component, status: :created, location: @component }
      else
        format.html { render action: "new" }
        # format.json { render json: @component.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @component = Component.find(params[:id])

    respond_to do |format|
      if @component.update_attributes(params[:component])
        format.html { redirect_to components_url, notice: 'Component was successfully updated.' }
        # format.json { head :no_content }
      else
        format.html { render action: "edit" }
        # format.json { render json: @component.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @component = Component.find(params[:id])
    @component.destroy

    respond_to do |format|
      format.html { redirect_to components_url }
      # format.json { head :no_content }
    end
  end
end

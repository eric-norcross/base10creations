class SearchesController < ApplicationController
  def index
    @results = PgSearch.multisearch(params[:product_search])

    if @results.length == 1 
      redirect_to product_sku_path(@results.first.searchable.product_id, @results.first.searchable.id)
    else 
      @side_nav_elements = Collection.all
      
      @products = @results.map{|result| result.searchable}

      render "layouts/templates/list"
    end
  end

  def update
    @actionable = [Compilation, Product, Sku]

    @actionable.each do |model|
      model.rebuild_pg_search_documents
    end

    flash[:notice] = 'All searchable records have been updated.'
    redirect_to :back
  end
end

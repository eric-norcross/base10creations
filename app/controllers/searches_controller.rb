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
end

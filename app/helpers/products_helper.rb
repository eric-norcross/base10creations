module ProductsHelper
  def association(product, finish)
    if product.include_finish_name
      return product.collection.get_patriarch_title + " " + finish.title
    else 
      return product.collection.get_patriarch_title
    end
  end

  def template_picker(item)
    if item.is_a?(Sku)
      return "layouts/partials/sku_list"
    elsif item.is_a?(Product)
      return "layouts/partials/product_list"
    elsif item.is_a?(Compilation)
      return "layouts/partials/compilation_list"
    else 
      return "layouts/partials/index_list"
    end
  end
end
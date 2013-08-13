module ProductsHelper
  def build_collection(element)
    @collection = Array.new

    @collection.push([element.id, element.title])
    if !element.children.blank?
      element.children.each do |child|
        build_collection(child)
      end
    end

    return @collection
  end

  def association(product, finish)
    if product.include_finish_name
      return product.collection.title + " " + finish.title
    else 
      return product.collection.title
    end
  end
end
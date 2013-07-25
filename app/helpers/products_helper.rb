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
end
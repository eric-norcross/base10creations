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


# - level = level + 1
# - @selected = false
# - if component.parent_id == component_selector.id
#   - @selected = true

# %option{ value: component_selector.id, selected: @selected, class: "level#{level} level" }
#   - level.times do 
#     \&nbsp;&nbsp;&nbsp;
#   = component_selector.title
# - if !component_selector.children.blank?
#   - component_selector.children.each do |child|
#     = render "components/component_select", component_selector: child, component: component, level: level


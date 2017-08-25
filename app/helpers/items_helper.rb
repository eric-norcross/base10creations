module ItemsHelper
  def build_items_relationships(item)
    item.build_link      if item.link.blank?
  end
end
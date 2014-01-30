class Family
  PATRIARCH     = "patriarch"
  PARENT        = "parent"
  CHILDREN      = "children"
  DESCENDANTS   = "descendants"
  LINEAGE       = "lineage"
  SIBLINGS      = "siblings"

  def self.children(elements, item) # returns children or empty array
    if elements.present? && item.present?
      return elements.select{|element| element.parent_id == item.id}
    end
  end

  def self.patriarch(elements, item) # returns patriarch or self if item is patriarch 
    if elements.present? && item.present?
      if item.parent_id == 0
        return item
      else 
        return patriarch(elements, parent(elements, item))
      end
    end
  end

  def self.descendants(elements, item) # returns descendants or self if there are no descendants
    items = []  # gets the direct children

    childElements = children(elements, item)

    items.push(childElements)

    childElements.each do |child|
      items.push(descendants(elements, child))
    end

    return items.flatten.uniq
  end

  def self.lineage(elements, item) # returns all descendants & self starting at the patriarch
    familyHead = patriarch(elements, item)
    return (descendants(elements, familyHead) + [familyHead]).flatten.uniq
  end

  def self.parent(elements, item)
    if elements.present? && item.present?
      if item.parent_id == 0
        return item
      else 
        return elements.select{|element| element.id == item.parent_id}.first
      end
    end
  end

  def self.siblings(elements, item)
    if elements.present? && item.present?
      if item.parent_id == 0
        return elements.select{|element| element.parent_id == item.parent_id}
      else 
        return children(elements, item)
      end
    end
  end
end
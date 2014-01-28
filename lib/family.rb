class Family
  def self.children(elements, item)
    if elements.present? && item.present?
      return elements.select{|element| element.parent_id == item.id}
    end
  end

  def self.patriarch(elements, item)
    if elements.present? && item.present?
      if item.parent_id == 0
        return item
      else 
        return patriarch(elements, parent(elements, item))
      end
    end
  end

  def self.decendants(elements, item)
    decendants = []
    if elements.present? && item.present?
      elements.each do |element|
        elementPatriarch = patriarch(elements, element)
        if elementPatriarch.id == item.id
          decendants.push(element) 
        end
      end
    end

    if decendants.blank?
      decendants.push(item)
    end

    return decendants
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
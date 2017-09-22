class SectionPresenter < BasePresenter
  attr_reader :section

  def initialize(instance)
    super(instance)
    @section = instance
  end

  def image
    if self.images.present?
      self.images.sort_by(&:id).first
    end
  end

  def section_items
    self.items.map{ |item| ItemPresenter.new(item) }
  end

  def shown_children
    self.children.where(shown: true)
  end
end
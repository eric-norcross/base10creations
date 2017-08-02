class PagePresenter < BasePresenter
  attr_reader :page

  def initialize(instance)
    super(instance)
    @page = instance
  end

  def random_image
    if self.images.length > 0
      # TODO: Add randomization here
      self.images.sort_by(&:id).first
    end
  end

  def random_quote
    Quote.first
  end

  def page_sections
    self.sections.map{ |section| SectionPresenter.new(section) }
  end

  

end
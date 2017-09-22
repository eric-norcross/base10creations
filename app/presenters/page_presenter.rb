class PagePresenter < BasePresenter
  attr_reader :page

  GROUPED_SECTIONS  = ["about", "tools"]

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

  def grouped_sections
    self.sections.where(slug: GROUPED_SECTIONS, shown: true).map{ |section| SectionPresenter.new(section) }
  end

  def work_sections
    self.sections.where.not(slug: GROUPED_SECTIONS, shown: false).map{ |section| SectionPresenter.new(section) }
  end
end
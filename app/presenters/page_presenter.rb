module PagePresenter
  extend ActiveSupport::Concern

  GROUPED_SECTIONS  = ["about", "tools"]

  def random_quote
    Quote.first
  end

  def grouped_sections
    sections.where(slug: GROUPED_SECTIONS, shown: true)
  end

  def work_sections
    sections.where.not(slug: GROUPED_SECTIONS, shown: false)
  end
end
module SectionPresenter
  extend ActiveSupport::Concern

  def shown_children
    children.where(shown: true)
  end
end
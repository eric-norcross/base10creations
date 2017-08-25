module SectionsHelper
  def build_section_relationships(section)
    section.build_link      if section.link.blank?
    section.figures.build   if section.figures.blank?
  end

  def associated_page(section)
    if section.page.present?
      return section.page
    elsif section.parent.present?
      return associated_page(section.parent)
    end
  end
end
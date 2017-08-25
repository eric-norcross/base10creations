module PagesHelper
  def build_page_relationships(page)
    page.build_link       if page.link.blank?
    page.sections.build   if page.sections.blank?
  end

  def main_navigation
    Page.friendly.find("home").sections
  end
end
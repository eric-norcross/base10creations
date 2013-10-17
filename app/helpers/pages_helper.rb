module PagesHelper
  def category
    if @page.category
      @page.category
    else 
      @page.section.category
    end
  end
end
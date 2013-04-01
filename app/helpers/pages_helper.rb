module PagesHelper

  def category
    # @page.category
    if @page.category
      @page.category
    else 
      @page.section.category
    end
  end
end

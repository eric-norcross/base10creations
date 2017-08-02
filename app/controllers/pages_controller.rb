class PagesController < ApplicationController
  def show
    page            = Page::Page.includes(
                        :figures,
                        sections: [
                          :figures, 
                          :items
                        ],
                      ).friendly.find(params[:id])

    page_presenter  = PagePresenter.new(page)

    render :show, locals: { page_presenter: page_presenter }
  end

  private 
end

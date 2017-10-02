class PagesController < ApplicationController
  caches_action :show

  def show
    @page = Page::Page.includes(
              :link,
              :figures,
              sections: [
                :link,
                :figures, 
                :items,
                children: [
                  :link,
                  :figures, 
                  :items
                ]
              ]
            ).find_by_slug(
              params[:id]
            )
  end

  private 
end

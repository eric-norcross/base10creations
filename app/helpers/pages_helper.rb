module PagesHelper

  def category
    # @page.category
    if @page.category
      @page.category
    else 
      @page.section.category
    end
  end

  def recursor(element)
    haml_tag :li do
      haml_concat link_to element.title, element
      
      if !element.children.blank?
        haml_tag :ul do
          element.children.each do |child|
            recursor(child)
          end
        end
      end
    end
  end

  def form_recursor(section)
    content_tag(:div, class: "checkbox") do
      tag(:label, for: "blah") do
      end

      tag(:input, type: "radio", name: "blah", value: "1") do
      end
    end
      
      # radio_button_tag "section#{section.id}", section.id, :name => 'style[section_ids][]'
      # label_tag "section#{section.id}", section.title
      
      # if !element.children.blank?
      #   haml_tag :ul do
      #     element.children.each do |child|
      #       recursor(child)
      #     end
      #   end
      # end
  end
end

module ApplicationHelper
  def create_columns
    Category.products.each_slice(2) do |column|
      haml_tag :div, class: "column" do
        column.each do |category|
          haml_tag :h1, category.title
          haml_tag :ul do
            category.components.each do |component|
              haml_tag :li do
                haml_concat link_to component.title, component
              end
            end
          end
        end
      end
    end
  end
end
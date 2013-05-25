module ProductsHelper
  def link_to_remove_fields(f) 
    f.hidden_field(:_destroy) + link_to("Remove", "#", class: "remove-fields")
  end

  def link_to_add_fields(name, f, association, container)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end

    link_to "Add Fields", "#", class: "add-fields", data: { container: "#{container}", association: "#{association}", content: "#{fields}" }
  end
end

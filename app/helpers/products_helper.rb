module ProductsHelper
  def link_to_remove_fields(f) 
    f.hidden_field(:_destroy) + link_to("Remove", "#", class: "remove-fields")
  end

  def link_to_remove_fields(f) 
    f.hidden_field(:_destroy) + link_to("Remove", "#", class: "remove-fields")
  end

  def link_to_add_fields(name, f, association, container, child_association = nil)
    new_object = f.object.send(association).klass.new

    if child_association
      #3.times{ new_object.send(child_association).build } #Builds 3 Answers
      #new_object.send(child_association).build #Builds 1 Answer
    end
  
    id = new_object.object_id

    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s + "/" + association.to_s.singularize + "_fields", f: builder)
    end
    
    # link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})

    # fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
    #   render(association.to_s + "/" + association.to_s.singularize + "_fields", :f => builder)
    # end

    link_to name, "#", class: "add-fields", data: { id: id, container: "#{container}", association: "#{association}", content: "#{fields}" }
  end
end

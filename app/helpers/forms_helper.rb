module FormsHelper
  def checked(check_box_value)
    if check_box_value || check_box_value == false
      @checked = check_box_value
    else 
      @checked = true
    end

    return @checked
  end

  def randomNum()
    SecureRandom.random_number(100000)
  end

  def link_to_remove_fields(f) 
    f.hidden_field(:_destroy, class: "destroy") + 
    link_to("#", class: "remove") do 
      content_tag(:i, "", class: "icon-remove-circle icon-large", title: "Remove")
      # + content_tag(:span, " - Remove")
    end
  end

  def link_to_add_fields(data)
    STDOUT << "name: " + data[:name].to_s + " :: "
    STDOUT << "f.object: " + data[:f].object.to_s + " :: "
    STDOUT << "association: " + data[:association].to_s + " :: "
    STDOUT << "container: " + data[:container].to_s + " :: "

    if data[:child_association]
      STDOUT << "child_association: " + data[:child_association].to_s + " :: "
    end

    # new_image = Image.new

    new_object = data[:f].object.send(data[:association]).klass.new

    if data[:child_association]
      #3.times{ new_object.send(child_association).build } #Builds 3
      new_object.send(data[:child_association]).build #Builds 1
    end
  
    id = new_object.object_id

    fields = data[:f].fields_for(data[:association], new_object, child_index: id) do |builder|
      render(data[:association].to_s.pluralize + "/" + data[:association].to_s.singularize + "_fields", f: builder, unique_id: id, options: data[:options])
    end

    link_to data[:name], "#", class: "add-fields", data: { id: id, container: "#{data[:container]}", association: "#{data[:association]}", content: "#{fields}" }
    
    # link_to("#", class: "add-fields", data: { id: id, container: "#{container}", association: "#{association}", content: "#{fields}" }) do
    #   content_tag(:i, "", class: "icon-plus-sign icon-large", title: "Add")
    # end
  end
end

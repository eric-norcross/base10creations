module FormsHelper
  def checked(check_box_value)
    if check_box_value || check_box_value == false
      @checked = check_box_value
    else 
      @checked = true
    end

    return @checked
  end

  def default_if_nil(default, value = nil)
    if value
      return value
    else 
      return default
    end
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

  # def link_to_add_fields(data)
  #   STDOUT << "\n"
  #   STDOUT << "Name: " + data[:name].to_s + "\n"
  #   STDOUT << "Parent (f.object): " + data[:f].object.to_s + "\n"
  #   STDOUT << "Association: " + data[:association].to_s + "\n"
  #   STDOUT << "Container: " + data[:container].to_s + "\n"

  #   if data[:child_association]
  #     STDOUT << "Child Association: " + data[:child_association].to_s + "\n"
  #   end

  #   # new_image = Image.new

    
  #   new_object = data[:f].object.send(data[:association]).build
  #   STDOUT << "Obj 1: " + new_object.inspect + "\n"

  #   # if new_object.is_a?(Carousel)
  #   #   STDOUT << "???: " + new_object.figures.to_s + "\n"
  #   # elsif new_object.is_a?(Figure)
  #   #   STDOUT << "???: " + new_object.images.to_s + "\n"
  #   # end

  #   if data[:child_association]
  #     STDOUT << "Sending child association: " + data[:child_association].to_s + "\n"
  #     #3.times{ new_object.send(child_association).build } #Builds 3
  #     # new_object.send(data[:child_association]).build #Builds 1
  #     # childobj = data[:child_association].klass.new
  #     new_child_object = new_object.send(data[:child_association]).build #Builds 1

  #     if new_object.is_a?(Carousel)
  #       STDOUT << "???: " + new_object.figures.to_s + "\n"
  #       new_child_object.send("images").build
  #     end

  #     STDOUT << "Obj 2: " + new_object.inspect + "\n"
  #   end

  #   if new_object.is_a?(Carousel)
  #     STDOUT << "???: " + new_object.figures.to_s + "\n"
  #   elsif new_object.is_a?(Figure)
  #     STDOUT << "???: " + new_object.images.to_s + "\n"
  #   end

  
  #   id = new_object.object_id

  #   fields = data[:f].fields_for(data[:association], new_object, child_index: id) do |builder|
  #     render(data[:association].to_s.pluralize + "/" + data[:association].to_s.singularize + "_fields", f: builder, unique_id: id, options: data[:options])
  #   end

  #   link_to data[:name], "#", class: "add-fields", data: { id: id, container: "#{data[:container]}", association: "#{data[:association]}", content: "#{fields}" }
    
  #   # link_to("#", class: "add-fields", data: { id: id, container: "#{container}", association: "#{association}", content: "#{fields}" }) do
  #   #   content_tag(:i, "", class: "icon-plus-sign icon-large", title: "Add")
  #   # end
  # end


  def link_to_add_fields(data)
    # Rails.logger.debug "Name: #{data[:name]}"
    # Rails.logger.debug "Parent (f.object): #{data[:f].object}"
    # Rails.logger.debug "Association: #{data[:association]}"
    # Rails.logger.debug "Nested: #{data[:nested]}"
    # Rails.logger.debug "Container: #{data[:container]}"

    model = recursor(data[:f].object, data)
    # Rails.logger.debug "model: #{model}"

    id = model.object_id
    # Rails.logger.debug "id: #{id}"

    fields = data[:f].fields_for(data[:association], model, child_index: id) do |builder|
      render(data[:association].to_s.pluralize + "/" + data[:association].to_s.singularize + "_fields", f: builder, unique_id: id, options: data[:options])
    end

    link_to data[:name], "#", class: "add-fields", data: { id: id, container: "#{data[:container]}", association: "#{data[:association]}", content: "#{fields}" }
  end

  def recursor(parent, data)
    # Rails.logger.debug "Recursor - parent: #{parent}"
    # Rails.logger.debug "Recursor - association: #{data[:association]}"
    # Rails.logger.debug "Recursor - nested array: #{data[:nested]}"

    model = parent.send(data[:association]).build
    # Rails.logger.debug "Recursor - model: #{model.inspect}"
    
    unless data[:nested].blank?
      data[:nested].each do |nested_association|
        # Rails.logger.debug "Recursor - nested association: #{nested_association[:association]}"
        # Rails.logger.debug "Recursor - nested array: #{nested_association[:nested]}"
        recursor(model, {association: nested_association[:association], nested: nested_association[:nested]})
      end
    end

    return model
  end
end

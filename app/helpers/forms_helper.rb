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

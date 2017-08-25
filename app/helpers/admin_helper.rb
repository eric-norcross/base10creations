module AdminHelper
  ADMIN_EXCLUDED  = [
                      "ckeditor_assets", 
                      "schema_migrations",
                      "friendly_id_slugs",
                      "admins",
                      "trackers"
                    ]

  def manage_table_list
    excluded_tables = ADMIN_EXCLUDED

    return ActiveRecord::Base.connection.tables.map{|table| table.to_s unless excluded_tables.include?(table.to_s)}.compact.sort_by!{ |table_name| table_name.to_s}
  end

  def cl_input_id(object_name, method)
    return "#{object_name}[#{method}]".parameterize.tableize.singularize
  end

  def figureable_types
    [
      ["Page",        "Page"],
      ["Section",     "Section"]
    ]
  end
end
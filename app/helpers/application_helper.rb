module ApplicationHelper
  def uri?(string)
    uri = URI.parse(string)
    %w( http https ).include?(uri.scheme)
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end

  def messenger_path
    url_for(controller: 'messages', action: 'create')
    
    # messenger = controller.controller_name.singularize
    # messages_path(:messenger_type => messenger, :messenger_id => controller.instance_variable_get("@#{messenger}").id)
  end

  def provinces
    [
      ["Alabama",          "AL"],
      ["Alaska",           "AK"],
      ["Arizona",          "AZ"],
      ["Arkansas",         "AR"],
      ["California",       "CA"],
      ["Colorado",         "CO"],
      ["Connecticut",      "CT"],
      ["Delaware",         "DE"],
      ["Dist of Columbia", "DC"],
      ["Florida",          "FL"],
      ["Georgia",          "GA"],
      ["Hawaii",           "HI"],
      ["Idaho",            "ID"],
      ["Illinois",         "IL"],
      ["Indiana",          "IN"],
      ["Iowa",             "IA"],
      ["Kansas",           "KS"],
      ["Kentucky",         "KY"],
      ["Louisiana",        "LA"],
      ["Maine",            "ME"],
      ["Maryland",         "MD"],
      ["Massachusetts",    "MA"],
      ["Michigan",         "MI"],
      ["Minnesota",        "MN"],
      ["Mississippi",      "MS"],
      ["Missouri",         "MO"],
      ["Montana",          "MT"],
      ["Nebraska",         "NE"],
      ["Nevada",           "NV"],
      ["New Hampshire",    "NH"],
      ["New Jersey",       "NJ"],
      ["New Mexico",       "NM"],
      ["New York",         "NY"],
      ["North Carolina",   "NC"],
      ["North Dakota",     "ND"],
      ["Ohio",             "OH"],
      ["Oklahoma",         "OK"],
      ["Oregon",           "OR"],
      ["Pennsylvania",     "PA"],
      ["Rhode Island",     "RI"],
      ["South Carolina",   "SC"],
      ["South Dakota",     "SD"],
      ["Tennessee",        "TN"],
      ["Texas",            "TX"],
      ["Utah",             "UT"],
      ["Vermont",          "VT"],
      ["Virginia",         "VA"],
      ["Washington",       "WA"],
      ["West Virginia",    "WV"],
      ["Wisconsin",        "WI"],
      ["Wyoming",          "WY"]
    ]
  end

  def create_columns
    Category.all.each_slice(2) do |column|
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
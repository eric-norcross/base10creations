module ApplicationHelper
  require "net/http"

  def linked(item)
    if item.link.present?
      link_to item.name, item.link.uri, target: item.link.target
    else 
      item.name
    end
  end

  def link_to_if_linked(section_link, &block)
    if section_link.link.present?
      link_to(section_link.link.uri, {target: section_link.link.target}, &block)
    else
      puts block.call
    end
  end

  def val(obj)
    obj || '&mdash;'.html_safe
  end

  def zero_width_space
    return ''
  end

  def blank
    "&mdash;".html_safe
  end

  def bool(value)
    if value.present?
      "&#x2713;".html_safe
    else
      "&mdash;".html_safe
    end
  end

  def url_exists?(url_string)
    # Rails::logger.debug "***************************************************************************"
    # Rails::logger.debug "ApplicationHelper - url_exists? - url_string.inspect: #{url_string.inspect}"
    # Rails::logger.debug "***************************************************************************"
        
    if url_string.present?
      begin
        url = URI.parse(url_string)
        # Rails::logger.debug "***************************************************************************"
        # Rails::logger.debug "ApplicationHelper - url_exists? - url.inspect: #{url.inspect}"
        # Rails::logger.debug "***************************************************************************"

        req = Net::HTTP.new(url.host, url.port)
        # Rails::logger.debug "***************************************************************************"
        # Rails::logger.debug "ApplicationHelper - url_exists? - req.inspect: #{req.inspect}"
        # Rails::logger.debug "***************************************************************************"

        req.use_ssl = (url.scheme == 'https')
        # Rails::logger.debug "***************************************************************************"
        # Rails::logger.debug "ApplicationHelper - url_exists? - url.scheme: #{url.scheme.inspect}"
        # Rails::logger.debug "ApplicationHelper - url_exists? - req.use_ssl.inspect: #{req.inspect}"
        # Rails::logger.debug "***************************************************************************"

        path = url.path if url.path.present?
        # Rails::logger.debug "***************************************************************************"
        # Rails::logger.debug "ApplicationHelper - url_exists? - path.inspect: #{path.inspect}"
        # Rails::logger.debug "***************************************************************************"

        res = req.request_head(path || '/')
        # Rails::logger.debug "***************************************************************************"
        # Rails::logger.debug "ApplicationHelper - url_exists? - res.inspect: #{res.inspect}"
        # Rails::logger.debug "***************************************************************************"

        res.code != "404" # false if returns 404 - not found
      rescue Errno::ENOENT
        false # false if can't find the server
      end
    else
      false
    end
  end

  def display_name(object)
    if object.present?
      if object.instance_of?(Hash)
        subject = object.with_indifferent_access
      else
        subject = object.attributes.with_indifferent_access
      end

      if subject[:title].present?
        subject[:title]
      elsif subject[:name].present?
        subject[:name]
      elsif subject[:identifier].present?
        subject[:identifier]
      elsif subject[:slug].present?
        subject[:slug]
      end
    end
  end

  def row_color(category)
    if category.children.present?
      ""
    else
      "#9ebeff"
    end
  end
end

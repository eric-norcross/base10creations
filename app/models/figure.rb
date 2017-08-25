# == Schema Information
#
# Table name: figures
#
#  alt             :string(255)
#  created_at      :datetime         not null
#  figureable_id   :integer
#  figureable_type :string
#  id              :integer          not null, primary key
#  image           :string           not null
#  title           :string(255)
#  updated_at      :datetime         not null
#

class Figure < ApplicationRecord
  mount_uploader                    :image, ImageUploader


  # Scopes
  # ==========================================================================================================
    default_scope                   { order(id: :ASC) }


  # Figureable (Polymorphic)
  # ==========================================================================================================
    belongs_to                      :figureable,
                                      polymorphic:    true, 
                                      optional:       true

  # Validations
  # ==========================================================================================================
    validates                       :image,
                                      presence:       true

    validates                       :figureable_type,
                                      presence:       true



  # Callbacks
  # ==========================================================================================================

  # Public methods
  # ==========================================================================================================
    def asset
      self.image_url
    end

    def cl_asset
      self.image.filename
    end

    def full_path
      ApplicationController.helpers.cloudinary_url(self.image)
    end


  # Public Static methods
  # ==========================================================================================================
    def self.find_duplicates
      figures = Figure.all.pluck(:image)
      figures.group_by{ |e| e }.select { |k, v| v.size > 1 }.map(&:first)
      return figures.sort.chunk{ |e| e }.select { |e, chunk| chunk.size > 1 }.map(&:first)

      # figures = Figure.all
      # figures.all.detect{ |e| figures.count(e) > 1 }
    end

  # Private methods
  # ==========================================================================================================
    private

    def self.url_exists?(url_string)
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

end

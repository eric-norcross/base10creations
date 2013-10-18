class Style < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  default_scope order('styles.title ASC')

  attr_accessible               :name, 
                                :title,
                                :description,
                                :link,

                                ## belongs_to ##

                                ## has_many ##
                                :collection_ids,

                                ## nested attributes ##
                                :images_attributes

  has_many                      :brand_styles, dependent: :destroy
  has_many                      :brands,       through: :brand_styles

  has_many                      :collection_styles, dependent: :destroy
  has_many                      :collections,       through: :collection_styles

  has_many                      :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true
  
  validates_presence_of         :collections
  validates_presence_of         :title

  before_save                   :create_name

  def self.products(style_id = :id)
    return Product.all(:conditions => { :collection_id => collection_ids(style_id) })
  end

  def self.compilations(style_id = :id)
    return Compilation.all(:conditions => { :collection_id => collection_ids(style_id) })
  end

  def self.products_and_compilations(style_id = :id)
    return (products(style_id) + compilations(style_id)).sort_by(&:name)
  end

  def path
    if link && link != ""
      return link
    else
      return style_path(id)
    end
  end

  def list_image
    if images.length > 0 
      return images.first.asset.filename.to_s
    else
      return Image.default.to_s
    end
  end

  private

    def self.collection_ids(style_id = :id)
      return Style.find(style_id).collection_ids
    end

    def create_name
      self.name = title.parameterize
    end
end

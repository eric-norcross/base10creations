class Brand < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  default_scope order('brands.name ASC')

  attr_accessible               :name, 
                                :title,

                                ##belongs_to##

                                ##has_many##
                                :style_ids,

                                ## nested attributes ##
                                :images_attributes,
                                :figures_attributes

  has_many                      :brand_styles, dependent: :destroy
  has_many                      :styles,       through: :brand_styles

  has_many                      :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

  has_many                      :figures, dependent: :destroy
  accepts_nested_attributes_for :figures, reject_if: lambda { |a| a[:link].blank?}, allow_destroy: true

  validates_presence_of         :title
  validates_presence_of         :styles

  before_save                   :create_name

  def self.styles(brand_id = :id)
    return Style.where(:brand_id => brand_id)
  end

  def self.products(brand_id = :id)
    return Product.where(:collection_id => collection_ids(brand_id))
  end

  def self.compilations(brand_id = :id)
    return Compilation.where(:collection_id => collection_ids(brand_id))
  end

  def self.products_and_compilations(brand_id = :id)
    return (products(brand_id) + compilations(brand_id)).sort_by(&:name)
  end

  def path
    return brand_path(id)
  end

  def list_image
    if images.length > 0 
      return images.first.asset.filename.to_s
    else
      return Image.default.to_s
    end
  end

  private
  
    def create_name
      self.name = title.parameterize
    end

    def self.collection_ids(brand_id = :id)
      collection_ids = Array.new

      styles(brand_id).each do |style|
        style.collections.each do |collection|
          collection_ids.push(collection.id) unless collection_ids.include?(collection.id)
        end
      end

      return collection_ids
    end
end

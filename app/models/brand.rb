class Brand < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  default_scope order('brands.name ASC')

  attr_accessible               :name, 
                                :title,
                                :description,
                                :link,

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

  has_many                      :figures, as: :figurable, dependent: :destroy
  accepts_nested_attributes_for :figures, reject_if: lambda { |a| a[:link].blank?}, allow_destroy: true

  validates_presence_of         :title
  validates                     :link, :format => /(^$)|(^(http:\/\/|https:\/\/|\/))/ix
  validates_presence_of         :styles

  before_save                   :create_name


  def products
    return Product.where(collection_id: collection_ids)
  end

  def compilations
    return Compilation.where(collection_id: collection_ids)
  end

  def products_and_compilations
    return (products + compilations).sort_by(&:name)
  end

  def path
    if link && link != ""
      return link
    else
      return brand_path(id)
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
  
    def create_name
      self.name = title.parameterize
    end

    def collection_ids
      ids = []

      styles.each do |style|
        ids.push(style.collections.map{|collection| collection.id})
      end

      return ids.uniq
    end
end

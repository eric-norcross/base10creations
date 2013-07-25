class Brand < ActiveRecord::Base
  default_scope order('brands.title ASC')

  attr_accessible               :name, 
                                :title,

                                ##belongs_to##

                                ##has_many##
                                :style_ids,

                                ## nested attributes ##
                                :images_attributes

  has_many                      :styles

  has_many                      :images, as: :imageable, :dependent => :destroy
  accepts_nested_attributes_for :images, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true


  validates_presence_of         :title

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

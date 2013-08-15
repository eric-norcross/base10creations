# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  name       :text
#  sku        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  skin_id    :integer
#

class Product < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  default_scope order('products.id ASC')
  
  attr_accessible               :name, 
                                :title,
                                :features, 
                                :active,
                                :shown,
                                :video,
                                :include_finish_name,

                                ## belongs_to ##
                                :collection_id,
                                :skin_id,

                                ## has_many ##
                                :component_ids,

                                ## nested attributes ##
                                :skus_attributes,
                                :dimensions_attributes,
                                :images_attributes
                        

  belongs_to                    :collection
  belongs_to                    :skin

  has_many                      :product_components,  :dependent  => :destroy
  has_many                      :components,          :through    => :product_components

  has_many                      :dimensions, dependent: :destroy
  accepts_nested_attributes_for :dimensions, reject_if: lambda { |a| a[:width].blank? || a[:height].blank? || a[:depth].blank? }, allow_destroy: true

  has_many                      :skus, dependent: :destroy
  accepts_nested_attributes_for :skus, reject_if: lambda { |a| a[:title].blank? }, allow_destroy: true
  
  has_many                      :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

  validates_presence_of         :skus
  validates_presence_of         :title
  validates_presence_of         :collection
  validates_presence_of         :skin

  before_save                   :create_name

  def show
    if self.active && self.shown
      return true
    end

    return false
  end

  def path(sku = skus.first)
    return product_sku_path(id, sku.id)
  end

  def categories
    return components.map{ |component| component.categories }.flatten
  end 

  def brands
    @brand_ids = collection.styles.map{ |style| style.brand_id }
    @brands = Brand.where(id: @brand_ids)
    return @brands
  end

  # def self.skus_by_finish(finish_id)
  #   @skus = Sku.where(finish_id: finish_id);
  #   return @skus
  # end

  def list_image
    if images.length > 0 
      return images.first
    else
      if skus.length == 0
        return Image.default
      else 
        if skus.first.images.length > 1
          return skus.first.images.second
        else 
          return skus.first.images.first
        end
      end
    end
  end

  private
  
  def create_name
    self.name = title.parameterize
    # self.name = component.title.parameterize
  end


  # Things to look into for validation:
  # validates_associated :user


  # has_many                      :skus, dependent: :destroy
  # accepts_nested_attributes_for :skus, reject_if: :validate_skus , allow_destroy: true
  # def validate_skus(attributes)
  #   attributes[:lskdjf].blank?
  #   if self.tasks.size < 1 || self.tasks.all?{|task| task.marked_for_destruction? }
  #     errors.add_to_base("A list must have at least one task.")
  #   end
  # end
end

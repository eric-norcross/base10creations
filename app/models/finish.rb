class Finish < ActiveRecord::Base
  default_scope order('finishes.title ASC')
  attr_accessible               :name,
                                :title,

                                ## belongs_to ##

                                ## has_many ##
                                :sku_ids,
                                :compilation_ids,

                                ## nested attributes ##
                                :image_attributes


  has_many                      :skus
  has_many                      :compilations

  has_many                      :image, as: :imageable, :dependent => :destroy
  accepts_nested_attributes_for :image, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

  validates_presence_of         :image
  validates_presence_of         :title

  before_save                   :create_name

  def self.skus(finish_id = :id)
    @skus = Sku.where(:finish_id => finish_id)
    return @skus
  end

  def self.products(finish_id = :id)
    @product_ids = []

    skus(finish_id).each do |sku|
      @product_ids.push(sku.product_id)
    end

    return Product.where(id: @product_ids)
  end

  def self.compilations(finish_id = :id)
    @compilation_ids = []

    skus(finish_id).each do |sku|
      @compilation_ids.push(sku.compilation_id)
    end

    return Compilation.where(id: @compilation_ids)
  end

  def self.products_and_compilations(finish_id = :id)
    return products(finish_id) + compilations(finish_id)
  end

  private
  
  def create_name
    self.name = title.parameterize
  end
end
class Compilation < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include PgSearch

  multisearchable against: [:title]

  attr_accessible 							:name, 
  															:title,
                                :active,
                                :include_finish_name,

  															# belongs_to ##
 																:skin_id,
                                :collection_id,
                                :finish_id,

                                ## has_many ##
																:sku_ids,

                                ## nested attributes ##
                                :images_attributes

  belongs_to                    :collection
  belongs_to                    :finish
  belongs_to                    :skin
    
  has_many                      :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

  has_many                      :compilation_skus, dependent: :destroy
  has_many                      :skus,             through: :compilation_skus
  # accepts_nested_attributes_for :compilation_skus,  :allow_destroy => true

	validates_presence_of         :title
  validates_presence_of         :collection
  validates_presence_of         :finish
  validates_presence_of         :skus
  validates_presence_of         :skin

	before_save                   :create_name

  def show
    return active
  end

  def path(sku = nil)
    if sku
      return compilation_product_sku_path(id, sku.product_id, sku.id)
    else
      return compilation_path(id)
    end
  end

  def products
    return Product.where(id: skus.map{ |sku| sku.product_id })
  end

  def categories
    @categories = []
    products.each do |product|
      product.categories.each do |category|
        @categories.push(category) unless @categories.include?(category)
      end
    end

    return @categories
  end

  def get_skus
    if defined?(finish)
      return Collection.skus_by_finish(collection_id, finish_id).sort_by{|p| p[:title].gsub(/\D/, '').to_i}
    else
      return nil
    end
  end

  def selected_skus
    if skus.length > 0
      return skus.map{ |sku| sku.id }
    else
      return nil
    end
  end

  #View Helpers

  def list_image
    if images.length > 0 
      return images.first.asset.filename.to_s
    else 
      if skus.length == 0
        return Image.default.to_s
      else 
        return skus.first.images.first.asset.filename.to_s
      end
    end
  end

  def gallery_items
    @skus_images = []

    skus.each do |gallery_sku|
      gallery_sku.images.each do |sku_image|
        @skus_images.push(sku_image) unless @skus_images.include?(sku_image)
      end
    end

    return images + @skus_images + finish.images
  end

  def videos
    @videos = []

    products.each do |product|
      if product.video && product.video != ""
        @videos.push(product.video)
      end
    end

    return @videos
  end

  def brands
    @brands = []

    products.each do |product|
      product.brands.each do |brand|
        @brands.push(brand) unless @brands.include?(brand)
      end
    end

    return @brands
  end

  def self.rebuild_pg_search_documents
    find_each { |record| record.update_pg_search_document }
  end


	private

    def create_name
      self.name = title.parameterize
    end                             
end
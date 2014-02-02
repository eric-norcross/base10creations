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
  validates_presence_of         :skin, message: "template is required."

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

  def categories(id = collection_id)
    return Category.categories_by_collection(id)
  end 

  def get_skus
    Rails.logger.debug "DEBUG - finish.present?: #{finish.present?}"


    if finish.blank? || collection.blank?
      return nil
    else
      return Collection.skus_by_finish(collection_id, finish_id).sort_by{|p| p[:title].gsub(/\D/, '').to_i}
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
    skus_images = []

    skus.each do |gallery_sku|
      gallery_sku.images.each do |sku_image|
        skus_images.push(sku_image) unless skus_images.include?(sku_image) || !sku_image.active
      end
    end

    return images + skus_images + finish.images
  end

  def videos
    @videos = []

    products.each do |product|
      @videos + product.videos
    end

    return @videos
  end 

  def brands
    return collection.get_brands
    # @brands = []

    # products.each do |product|
    #   product.brands.each do |brand|
    #     @brands.push(brand) unless @brands.include?(brand)
    #   end
    # end

    # return @brands
  end

  def self.rebuild_pg_search_documents
    find_each { |record| record.update_pg_search_document }
  end


	private

    def create_name
      self.name = title.parameterize
    end                             
end
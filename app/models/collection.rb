class Collection < ActiveRecord::Base
  default_scope order('collections.name ASC')

  attr_accessible               :name, 
                                :title,
                                :description,

                                ##belongs_to##

                                ##has_many##,
                                :style_ids


  has_many                      :collection_styles,     :include => :style
  has_many                      :styles,                :through => :collection_styles
  accepts_nested_attributes_for :collection_styles,     :allow_destroy => true
  
  validates_presence_of         :title
  validates_presence_of         :description

  before_save                   :create_name


  def self.finishes(collection_id)
    return Finish.where(id: finish_ids(collection_id))
  end

  def self.products(collection_id)
    return Product.where(collection_id: collection_id)
  end

  def self.compilations(collection_id)
    return Compilation.where(collection_id: collection_id)
  end

  def self.products_and_compilations(collection_id)
    return (products(collection_id) + compilations(collection_id)).sort_by(&:name)
  end

  def categories
    @products_and_compilations = self.class.products_and_compilations(id)
    @categories = []
    @products_and_compilations.each do |item|
      item.categories.each do |category| 
        @categories.push(category) unless @categories.include?(category)
      end
    end

    return @categories
  end


  private
  
    def create_name
      self.name = title.parameterize
    end

    def self.finish_ids(collection_id)
      finish_ids = Array.new
      products(collection_id).each do |product|
        product.skus.each do |sku|
          finish_ids.push(sku.finish_id) unless finish_ids.include?(sku.finish_id)
        end
      end

      return finish_ids
    end
end

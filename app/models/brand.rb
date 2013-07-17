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

  def self.products(params)
    @styles = Style.where(:brand_id => params[:id])
    # @style_ids = @styles.map{ |style| style.id }
    # @collection_styles = CollectionStyle.where(:style_id => @style_ids)
    # @collection_ids = @collection_styles.map{ |collection_style| collection_style.collection_id }

    collection_ids = Array.new

    @styles.each do |style|
      style.collections.each do |collection|
        collection_ids.push(collection.id) unless collection_ids.include?(collection.id)
      end
    end
    
    @products = Product.where(:collection_id => collection_ids)
    return @products
  end

  private
  
  def create_name
    self.name = title.parameterize
  end
end

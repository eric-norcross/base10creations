class Style < ActiveRecord::Base
  default_scope order('styles.title ASC')

  attr_accessible               :name, 
                                :title,
                                :description,

                                ##belongs_to##
                                :brand_id,

                                ##has_many##
                                :collection_ids
                                # :brand_ids

  # has_many                      :component_styles,  :dependent => :destroy
  # has_many                      :components,        :through => :component_styles

  # has_many                      :brand_styles,      :dependent => :destroy
  # has_many                      :brands,            :through => :brand_styles

  has_many                      :collection_styles, :include => :collection
  has_many                      :collections,       :through => :collection_styles
  accepts_nested_attributes_for :collection_styles, :allow_destroy => true

  belongs_to                    :brand
  
  #validates_presence_of        :collection
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


  private

    def self.collection_ids(style_id = :id)
      # return CollectionStyle.where(:style_id => style_id).map{|collection_style| collection_style.collection_id}
      return Style.find(style_id).collection_ids
    end

    def create_name
      self.name = title.parameterize
    end
end

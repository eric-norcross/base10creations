class Sku < ActiveRecord::Base
  default_scope order('skus.id ASC')

  attr_accessible               :name,
                                :title,

                                ## belongs_to ##
                                :product_id,

                                ## has_one ##
                                :finish_id,

                                ## has_many ##
                                # :finish_ids,

                                ## nested attributes ##
                                :images_attributes

  belongs_to                    :product
  belongs_to                    :finish

  has_many                      :images, as: :imageable, :dependent => :destroy
  accepts_nested_attributes_for :images, reject_if: proc { |attrs| attrs['asset'].blank? && attrs['asset_cache'].blank? }, allow_destroy: true

  # validates_presence_of         :images
  validates_presence_of         :title

  before_save                   :create_name

  private
  
  def create_name
    self.name = title.parameterize
  end

end

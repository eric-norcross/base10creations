class Sku < ActiveRecord::Base
  attr_accessible               :identifier,
                                :product_id,
                                :finish_id

  belongs_to                    :product

  has_one                       :finish, :dependent => :destroy
  accepts_nested_attributes_for :finish, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
end

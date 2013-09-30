class CompilationSku < ActiveRecord::Base
  attr_accessible :compilation_id, 
                  :sku_id

  belongs_to      :compilation
  belongs_to      :sku

  validates       :compilation_id,  presence: true
  validates       :sku_id,          presence: true
end


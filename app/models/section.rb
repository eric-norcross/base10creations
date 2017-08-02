# == Schema Information
#
# Table name: sections
#
#  content    :text
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  page_id    :integer          not null
#  slug       :string           not null
#  updated_at :datetime         not null
#

class Section < ApplicationRecord
  extend FriendlyId
  friendly_id                       :name,
                                      use: :slugged
                                      
  # Scopes
  # ==========================================================================================================
    default_scope                   { order(id: :ASC) }


  # Page
  # ==========================================================================================================
    belongs_to                      :page,
                                      inverse_of:     :sections


  # Figures (Polymorphic)
  # ==========================================================================================================
    has_many                        :figures,
                                      ->              { order(:id) },
                                      as:             :figureable,
                                      dependent:      :destroy

    accepts_nested_attributes_for   :figures,
                                      allow_destroy:  true,
                                      reject_if:      -> (attributes) {
                                                        attributes['image'].blank?
                                                      }


  # Link (Polymorphic)
  # ==========================================================================================================
    has_one                         :link,
                                      as:             :linkable,
                                      dependent:      :destroy

    accepts_nested_attributes_for   :link,
                                      allow_destroy:  true


  # Items
  # ==========================================================================================================
    has_many                        :items,
                                      inverse_of:     :section,
                                      dependent:      :destroy

    accepts_nested_attributes_for   :items,
                                      allow_destroy:  true


  # Validations
  # ==========================================================================================================
    validates                       :page,
                                      presence:       true

  # Callbacks
  # ==========================================================================================================

  # Public methods
  # ==========================================================================================================

  # Private methods
  # ==========================================================================================================
    private

end

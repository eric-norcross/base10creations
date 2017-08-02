# == Schema Information
#
# Table name: pages
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  slug       :string           not null
#  updated_at :datetime         not null
#

class Page < ApplicationRecord
  extend FriendlyId
  friendly_id                       :name,
                                      use: :slugged

  # Scopes
  # ==========================================================================================================
    default_scope                   { order(id: :ASC) }


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


                                      
  # Sections
  # ==========================================================================================================
    has_many                        :sections,
                                      inverse_of:     :page,
                                      dependent:      :destroy

    accepts_nested_attributes_for   :sections,
                                      allow_destroy:  true


  # Validations – Required
  # ==========================================================================================================
    validates                       :name,
                                      presence:       true,
                                      format:         { with: /[0-9a-zA-Z\s\/_:\-.|]*/ }

    validates                       :slug,
                                      presence:       true,
                                      uniqueness:     true,
                                      format:         { with: /[0-9a-z\-.]*/ }

  # Validations – Optional
  # ==========================================================================================================


  # Callbacks
  # ==========================================================================================================

  # Public methods
  # ==========================================================================================================

  # Private methods
  # ==========================================================================================================
    private

end

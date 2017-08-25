# == Schema Information
#
# Table name: sections
#
#  content         :text
#  created_at      :datetime         not null
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  page_id         :integer
#  parent_id       :integer
#  section_type_id :integer          default(1), not null
#  shown           :boolean          default(TRUE), not null
#  slug            :string           not null
#  updated_at      :datetime         not null
#

class Section < ApplicationRecord
  extend FriendlyId
  friendly_id                       :name,
                                      use: :slugged
                                      
  # Scopes
  # ==========================================================================================================
    default_scope                   { order(id: :ASC) }


  # SectionType
  # ==========================================================================================================
    belongs_to                      :section_type,
                                      inverse_of:     :sections,
                                      optional:       true


  # Page
  # ==========================================================================================================
    belongs_to                      :page,
                                      inverse_of:     :sections,
                                      optional:       true


  # Parent (Section)
  # ==========================================================================================================
    belongs_to                      :parent,
                                      class_name:     "Section",
                                      inverse_of:     :children,
                                      optional:       true


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
                                      allow_destroy:  true,
                                      reject_if:      -> (attributes) {
                                                        attributes['uri'].blank?
                                                      }


  # Items
  # ==========================================================================================================
    has_many                        :items,
                                      ->              { order(:id) },
                                      dependent:      :destroy

    accepts_nested_attributes_for   :items,
                                      allow_destroy:  true,
                                      reject_if:      -> (attributes) {
                                                        attributes['name'].blank?
                                                      }


  # Children (Sub-Sections)
  # ==========================================================================================================
    has_many                        :children,
                                      class_name:     "Section",
                                      foreign_key:    :parent_id,
                                      inverse_of:     :parent,
                                      dependent:      :destroy

    accepts_nested_attributes_for   :children,
                                      allow_destroy:  true


  # Validations
  # ==========================================================================================================
    validates                       :section_type,
                                      presence:       true

  # Callbacks
  # ==========================================================================================================

  # Public methods
  # ==========================================================================================================

  # Private methods
  # ==========================================================================================================
    private

end

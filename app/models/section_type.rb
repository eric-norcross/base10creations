# == Schema Information
#
# Table name: section_types
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  updated_at :datetime         not null
#

class SectionType < ApplicationRecord
  # Constants
  # ==========================================================================================================
    CONTENT                         = 1
    WEBSITE                         = 2
    AD                              = 3
    CONTACT                         = 4

  # Scopes
  # ==========================================================================================================
    default_scope                   { order(id: :ASC) }

  # Sections
  # ==========================================================================================================
    has_many                        :sections,
                                      inverse_of:     :section_type,
                                      dependent:      :destroy

  # Validations
  # ==========================================================================================================
    validates                       :name,
                                      presence:       true,
                                      format:         { with: /[0-9a-zA-Z\s\/_:\-.|]*/ }

  # Callbacks
  # ==========================================================================================================

  # Public methods
  # ==========================================================================================================

  # Private methods
  # ==========================================================================================================
    private

end

# == Schema Information
#
# Table name: links
#
#  created_at    :datetime         not null
#  id            :integer          not null, primary key
#  linkable_id   :integer
#  linkable_type :string
#  target        :string(255)      default("_blank")
#  title         :string(255)
#  updated_at    :datetime         not null
#  uri           :text             not null
#

class Link < ApplicationRecord
  # Scopes
  # ==========================================================================================================
    default_scope                   { order(id: :ASC) }


  # Linkable (Polymorphic)
  # ==========================================================================================================
    belongs_to                      :linkable,
                                      polymorphic:    true, 
                                      optional:       true


  # Validations
  # ==========================================================================================================
    validates                       :uri,
                                      presence:       true

    validates                       :linkable_type,
                                      presence:       true

  # Callbacks
  # ==========================================================================================================

  # Public methods
  # ==========================================================================================================

  # Private methods
  # ==========================================================================================================
    private

end

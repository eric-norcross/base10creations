# == Schema Information
#
# Table name: quotes
#
#  author     :string(255)      not null
#  content    :text             not null
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  updated_at :datetime         not null
#

class Quote < ApplicationRecord
  # Scopes
  # ==========================================================================================================
    default_scope                   { order(id: :ASC) }


  # Validations
  # ==========================================================================================================
    validates                       :author,
                                      presence:       true,
                                      format:         { with: /[[:alpha:]\s\-.]*/ }

    validates                       :content,
                                      presence:       true,
                                      format:         { with: /[[:alpha:]\s\-.]*/ }

  # Callbacks
  # ==========================================================================================================

  # Public methods
  # ==========================================================================================================

  # Private methods
  # ==========================================================================================================
    private

end

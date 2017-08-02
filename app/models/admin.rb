# == Schema Information
#
# Table name: admins
#
#  created_at             :datetime         not null
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string(255)      not null
#  id                     :integer          not null, primary key
#  last_name              :string(255)      not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  updated_at             :datetime         not null
#

class Admin < ApplicationRecord
  # Devise
  # ==========================================================================================================
    devise                          :database_authenticatable, 
                                    # :registerable,
                                    :recoverable, 
                                    :rememberable, 
                                    :trackable, 
                                    :validatable
                                    # :confirmable, 
                                    # :lockable, 
                                    # :timeoutable,
                                    # :omniauthable

  # Scopes
  # ==========================================================================================================
    default_scope                     { order(id: :ASC) }


  
  # Validations
  # ==========================================================================================================
    validates                       :first_name,
                                      presence:       true,
                                      format:         { with: /[[:alpha:]\s\-]*/ }

    validates                       :last_name,
                                      presence:       true,
                                      format:         { with: /[[:alpha:]\s\-]*/ }

  private

end

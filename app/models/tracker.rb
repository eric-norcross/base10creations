# == Schema Information
#
# Table name: trackers
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  remote_ip  :string
#  updated_at :datetime         not null
#

class Tracker < ApplicationRecord
end

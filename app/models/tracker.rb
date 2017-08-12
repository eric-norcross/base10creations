# == Schema Information
#
# Table name: trackers
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  remote_id  :string
#  updated_at :datetime         not null
#

class Tracker < ApplicationRecord
end

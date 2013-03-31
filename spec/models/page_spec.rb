# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  header     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  skin_id    :string(255)
#

require 'spec_helper'

describe Page do
  pending "add some examples to (or delete) #{__FILE__}"
end

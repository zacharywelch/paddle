# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  email          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  win_count      :integer          default(0)
#  loss_count     :integer          default(0)
#  win_percentage :float
#

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end

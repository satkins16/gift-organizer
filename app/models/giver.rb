class Giver < ActiveRecord::Base
  has_many :gift_givers
  has_many :gifts, through: :gift_givers

end

class Gift < ActiveRecord::Base
  belongs_to :user
  has_many :givers
  has_many :gift_givers
  has_many :givers, through: :gift_givers

end

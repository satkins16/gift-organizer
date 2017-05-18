class Gift < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :gift_givers
  has_many :givers, through: :gift_givers

end

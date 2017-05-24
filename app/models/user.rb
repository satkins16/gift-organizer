class User < ActiveRecord::Base
  has_many :gifts
  has_many :events
  has_many :givers

  has_secure_password

end

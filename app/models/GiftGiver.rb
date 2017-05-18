class GiftGiver < ActiveRecord::Base
  belongs_to :gift
  belongs_to :giver
end

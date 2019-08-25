class Performance < ApplicationRecord
  belongs_to :player
  belongs_to :map
  belongs_to :team
end

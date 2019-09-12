class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true
  after_create -> (x) {update_count(1)}
  before_destroy -> (x) {update_count(-1)}

  def update_count(num)
    votable = self.votable
    votable.score += (self.direction * num)
    votable.save!
  end
end

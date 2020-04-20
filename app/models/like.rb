class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true
  validates :likable_id, presence: true
end

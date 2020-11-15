class Purchase < ApplicationRecord
  validates :item_id, :user_id, presence: true

  belongs_to :item
  belongs_to :user
  belongs_to :user
  #一旦コメントアウト
  # belongs_to :item
end

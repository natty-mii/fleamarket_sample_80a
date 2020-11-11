class SnsCredential < ApplicationRecord
  belongs_to :user, optinal: true
end

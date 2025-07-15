class Client < ApplicationRecord
  include NormalizesEmail

  has_many :opportunities, dependent: :destroy

  validates :name, presence: true
end

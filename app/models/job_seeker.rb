class JobSeeker < ApplicationRecord
  include NormalizesEmail

  has_many :job_applications

  validates :name, presence: true
end

module NormalizesEmail
  extend ActiveSupport::Concern

  included do
    normalizes :email, with: ->(email) { email.strip.downcase }

    validates :email,
      format: {
        with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
        message: "is invalid. Please enter a valid email address"
      },
      length: { maximum: 255 }
  end
end

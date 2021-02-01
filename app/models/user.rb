class User < ApplicationRecord
  has_many :ideas, dependent: :nullify
  has_secure_password
end

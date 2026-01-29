class User < ApplicationRecord
  has_secure_password
  
  # normalization to ensure email is always lowercase
  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
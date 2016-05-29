class JwtToken < ActiveRecord::Base
  

  has_many :jwt_users, dependent: :destroy
end

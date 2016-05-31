class JwtUser < ActiveRecord::Base
  belongs_to :jwt_token

  
end
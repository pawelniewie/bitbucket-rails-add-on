class Repo < ActiveRecord::Base
  belongs_to :jwt_token
end
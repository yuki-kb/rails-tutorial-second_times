class User < ApplicationRecord
	validates :name,presence: true
	validates :email,presence: true
	validates :user_id,presence: true
end

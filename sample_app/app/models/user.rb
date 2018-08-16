class User < ApplicationRecord
	validates :name,presence: true
					length: {maximum: 50}
	validates :email,presence: true
					length: {maximum: 255}
	validates :user_id,presence: true
					length: {maximum: 50}
end

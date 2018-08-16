class User < ApplicationRecord
	before_save {email.downcase!}
	before_save {user_id.downcase!}
	validates :name,  presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255},
					format: {with:VALID_EMAIL_REGEX },
					uniqueness: {case_sensitive: false}
	VALID_USER_ID_REGEX = /\A[a-z\d\-.]+\z/i
	validates :user_id,presence: true,length: {maximum: 50},
					format: {with:VALID_USER_ID_REGEX},
					uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password,presence: true,length: {minimum: 6}
end
class Airvm < ActiveRecord::Base
	attr_encrypted :user, :key => ENV["USERKEY"]
	attr_encrypted :password, :key => ENV["PASSWORDKEY"]

	validates :user, presence: true
	validates :password, presence: true
	validates :host, presence: true
end

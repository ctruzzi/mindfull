require 'digest'

# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  user_name          :string(255)
#  email              :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  encrypted_password :string(255)
#  salt               :string(255)
#

=begin
	Each user has classes that are assosiated with it. Each of those classes has sections that are associated with them.
	Each Page has
	It will be a double jump
=end	

class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :user_name, :email, :password, :password_confirmation

	has_many :clazzs

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :user_name,	:presence => true,
						:length => { :maximum => 50 }
	
	validates :email,	:presence 	=> true,
					 	:format => { :with => email_regex },
					 	:uniqueness 	=> true	


	#validates :password, :presence		=> true,
	#					 :confirmation 	=> true,
	#					 :length       	=> { :within => 6..40 }


	#Call encrypt_password method prior to saving in active record
	before_save :encrypt_password

	def self.authenticate(email,submitted_password)
		user = find_by_email(email)
		return nil if user.nil? #return nil if we cannot find user
		return user if user.has_password?(submitted_password)
		#returns nil if doesn't meet either
	end

	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end

	# Return true if the user's password matches the submitted password.
	def has_password?(submitted_password)
		# Compare encrypted_password with the encrypted version of submitted_password.
		encrypted_password == encrypt(submitted_password)
		#return true;
	end

	private

		def encrypt_password
			password ||= ""
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt(password)
		end

		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end

		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end

		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end


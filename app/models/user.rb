class User
  	include Mongoid::Document
	field :name, type: String
	field :phone, type: String
	field :email, type: String
	field :password_hash, type: String
	field :password_salt, type: String
	include Mongoid::Timestamps::Created
  	include Mongoid::Timestamps::Updated

	has_many :broadcasts, :class_name => "Conversation", :inverse_of => nil
	has_many :responses, :class_name => "Message", :inverse_of => nil

	attr_accessor :password, :password_confirm

	before_save :encrypt_password

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

	def self.authenticate(email, password)
		user = User.find_by(email: email)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end
end

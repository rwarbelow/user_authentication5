class User < ActiveRecord::Base
  #TODO : Use bcrypt to store hashed passwords and authenticate users
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password_hash, presence: true

  include BCrypt

    def password
      @password ||= Password.new(password_hash)
    end

    def password=(new_password)
      @password = Password.create(new_password)
      self.password_hash = @password
    end

    def self.authenticate(email, password)
	    user = User.find_by_email(email)
	    if user && user.password == password
	      user
	    else
	      nil
	    end
	  end

end
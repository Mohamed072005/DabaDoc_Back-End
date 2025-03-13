  class UserRepository
    def self.find_by_email(userEmail)
      user = User.where(email: userEmail).first
      raise Mongoid::Errors::DocumentNotFound.new(User, {email: userEmail}) unless user
      user
    end

    def self.find_by_id(id)
      user = User.where(_id: id).first
      raise Mongoid::Errors::DocumentNotFound.new(User, {email: userEmail}) unless user
      user
    end

    def self.create(user_params)
      User.create(user_params)
    end
  end


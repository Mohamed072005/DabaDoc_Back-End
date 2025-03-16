  class UserRepository
    def self.find_by_email(user_email)
      user = User.where(email: user_email).first
      raise Mongoid::Errors::DocumentNotFound.new(User, {email: user_email}) unless user
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


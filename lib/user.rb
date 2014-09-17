class User
  attr_reader :db, :user_name

  def initialize(db, user_name, password_hash)
    @db            = db
    @user_name     = user_name
    @password_hash = password_hash
  end

  def create?
    if valid_user_name?
      create
    else
      false
    end
  end

  def valid_user_name?
    users = db[:users].to_a
    users.none? { |user| user[:name] == user_name }
  end

  def create
    db[:users].insert(name: user_name, password_hash: @password_hash)
    true
  end

end

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
      true
    else
      false
    end
  end

  def valid_user_name?
    users = db[:users].to_a
    users.each do |user|
      return false if user[:name] == user_name
    end
    true
  end

  def create
    db[:users].insert(name: user_name, password_hash: @password_hash)
  end

end


#questions:
  #is DB creating users?  NO
  #are params[:success] being passed to the view?   YES
  #is it redirecting to the right view? KIND OF

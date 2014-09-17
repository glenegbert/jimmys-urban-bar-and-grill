class User
  attr_reader :db, :user_name

  def initialize(db, user_name, pw1, pw2)
    @db        = db
    @user_name = user_name
    @pass_hash = pw1 if valid_password?(pw1, pw2)
  end

  def valid_password?(pw1, pw2)
    pw1 == pw2
  end

  def valid_credentials?
    return false if @pass_hash.nil?
    users = db[:users].to_a
    users.each do |user|
      return false if user[:name] == params[:user_name]
    end
    true
  end

  def create
    db[:users].insert(name: user_name, password: @pass_hash)
  end

end


#questions:
  #is DB creating users?  NO
  #are params[:success] being passed to the view?   YES
  #is it redirecting to the right view? KIND OF

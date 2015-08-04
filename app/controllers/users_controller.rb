class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      set_community
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to signup_path
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def set_community
    domain = @user.email.split("@")[1]
    @user.community = find_community(domain)
    @user.save
  end 

  def find_community(domain)
    base_url = "https://raw.githubusercontent.com/Hipo/university-domains-list/master/world_universities_and_domains.json"
    response = Net::HTTP.get_response(URI.parse(base_url))
    data = response.body
    result = JSON.parse(data)
    result.each do |school|
      if school["domain"] == domain
        community = Community.find_by(name: school["name"])
        if community == nil 
          community = Community.create(name: school["name"])
        end 
        return community
      end 
    end 
  end 
end

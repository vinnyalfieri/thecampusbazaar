class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      community_valid = set_community
      ###################################
      # Set up a "Create a community"   #
      # option when no college found    #
      ###################################
      if community_valid == nil 
        #@user.destroy
        session[:user_id] = @user.id
        redirect_to '/communities/new'
      else 
        session[:user_id] = @user.id
        redirect_to root_path
      end 
      
    else
      redirect_to signup_path
    end
  end

  def edit
    @user = User.find(params[:id])
    @community = @user.community
  end

  def update
    @user = User.find(params[:id])
    @community = @user.community.id
    if @user.update_attributes(user_params)
      flash[:notice] = "Profile successfully updated"
      redirect_to user_path @user
    else 
      flash[:notice]  = "Please update again"
      redirect_to edit_user_path @user
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_community
    domain = @user.email.split("@")[1]
    community = find_community(domain)
    if community != nil
      @user.community = find_community(domain)
      @user.save
    else
      return nil 
    end 
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
    return nil
  end 
end

class UsersController < ApplicationController
  before_action :check_community, only: :show
  
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      community_valid = set_community
      if community_valid == nil 
        session[:user_id] = @user.id
        redirect_to search_path
      else 
        session[:user_id] = @user.id
        redirect_to root_path
      end 
      
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

      if ((params[:user][:password]== '')&&(params[:user][:new_password]== ''))
        @user.update_attributes(user_params)
        @user.save
        flash[:notice] = "Profile successfully updated"
        redirect_to user_path(@user)
      elsif !(params[:user][:new_password] ==  params[:user][:new_password_confirmation])
        flash[:notice] = "Passwords did not match"
        redirect_to edit_user_path @user
      elsif !(BCrypt::Password.new(current_user.password_digest) == params[:user][:password] )
        flash[:notice]  = "Old Password did not match"
        redirect_to edit_user_path @user
      elsif ((params[:user][:new_password] ==  params[:user][:new_password_confirmation]) && (BCrypt::Password.new(current_user.password_digest) == params[:user][:password]))
        @user.update_attributes(user_params)
        @user.password_digest = BCrypt::Password.create(params[:user][:new_password])
        @user.save
        flash[:notice] = "Profile successfully updated"
        redirect_to user_path(@user)
    end
  end

  def show
    @user = User.find(params[:id])
    if @user != current_user
      render :show_user
    end 
  end

  def show_user
  end 

  def destroy
    @user.avatar = nil
    @user.save
  end

  def venmo
    VenmoWrapper.new.authenticate_venmo(current_user,auth_hash)
    redirect_to user_path(current_user)
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :delete_avatar)
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

  def auth_hash
    request.env['omniauth.auth']
  end

  def check_community 
    unless current_user.community_id == User.find(params[:id]).community_id
      redirect_to root_path # halts request cycle
    end
  end 
end

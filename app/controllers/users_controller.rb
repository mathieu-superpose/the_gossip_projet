class UsersController < ApplicationController

  def show
    @user = current_user
  end 

  
  def new
    @user = User.new
  end 


  def create
    @user = User.new(user_params)
    @user.city_id = City.all.sample.id  

    if @user.save
      session[:user_id] = @user.id
      @message = "You have signed up succesfully, welcome to The Gossip Project !"
      flash[:success] = "You have signed up succesfully, welcome to The Gossip Project  !"
      redirect_to root_path
    else
      @alert = true
      @message = "Error: " + @user.errors.messages.to_a.flatten[1]
      render new_user_path
    end
  end 


  def user_params
    params.require(:user).permit(:first_name, :last_name, :age, :description, :email, :password, :password_confirmation)
  end

end

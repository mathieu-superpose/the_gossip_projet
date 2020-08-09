class SessionsController < ApplicationController


  def new

  end 


  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      remember(user)
      redirect_to root_path
      flash[:success] = "Bienvenue #{user.first_name}!"
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def current_user
    if session[:user_id]
      current_user = User.find_by(id: session[:user_id])
    elsif cookies[:user_id]
      user = User.find_by(id: cookies[:user_id])
      if user && BCrypt::Password.new(user.remember_digest).is_password?(cookies[:remember_token])
        log_in user
        current_user = user
      end
    end
  end

  def destroy
    log_out(current_user)
    @current_user = nil
    redirect_to root_path
  end 

end

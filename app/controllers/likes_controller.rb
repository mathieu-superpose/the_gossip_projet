class LikesController < ApplicationController
  before_action :set_user, only: [:create]
  before_action :find_gossip
  
  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
    @gossip.likes.create(user_id: current_user.id)
    end 
    redirect_to gossip_path(@gossip)
  end

  def destroy
    if ! (already_liked)
      flash[:notice] = "You can't like more than once"
    else
      Like.find_by(user_id: current_user.id).destroy
    end 
    redirect_to root_path
  end 

  private

  def find_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, gossip_id: params[:gossip_id]).exists?
  end

end

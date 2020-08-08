class GossipsController < ApplicationController
  before_action :set_user, only: [:new, :create, :show]
  before_action :require_author, only: [:edit, :update, :destroy]

  def show
    @gossip = Gossip.find(params[:id])
    @comment = Comment.new
    @comment.gossip_id = @gossip.id

  end

  # GET /users/new
  def new
  	@gossip = Gossip.new
  end

  # POST /users
  def create
    @gossip = Gossip.new(title: params[:title], content:params[:content], user_id: current_user.id)

    if @gossip.save
      @message = "The gossip was succesfully saved !"
      flash[:success] = "The gossip was succesfully saved !"
      redirect_to root_path
    else
      @alert = true
      @message = "Error: " + @gossip.errors.messages.to_a.flatten[1]
      render new_gossip_path
    end
  end

  def edit 
    @gossip = Gossip.find(params[:id])
  end 

  def update
    @gossip = Gossip.find(params[:id])
    gossip_params = params.require(:gossip).permit(:title, :content)

    if @gossip.update(gossip_params)
      flash[:success] = "The gossip was succesfully updated !"
      redirect_to gossip_path(@gossip.id)
    else
      @alert = true
      @message = "Error: " + @gossip.errors.messages.to_a.flatten[1]
      render "edit"
    end
  end


  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to root_path
  end 


  
  def require_author
    redirect_to login_path unless @gossip.user == current_user
  end

end

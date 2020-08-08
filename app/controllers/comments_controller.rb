class CommentsController < ApplicationController

  before_action :set_user, only: [:new, :create]


  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.create(content: params[:content], user_id: current_user.id, gossip: @gossip)
    redirect_to gossip_path(@gossip.id)
  end

  def edit 
    @comment = Comment.find(params[:id])
  end 

  def update
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
    @comment = @comment.update(content: params[:content], user_id: @gossip.user.id , gossip_id: @gossip.id)
    redirect_to gossip_path(params[:gossip_id])
  end

  def update2
    @gossip = Gossip.find(params[:id])
    @comment = Comment.find(params[:id])
    comment_params = params.require(:comment).permit(:content)

    @comment = @gossip.comments.create(params[:comment].permit(:content))

    if @comment.update(comment_params)
      flash[:success] = "The gossip was succesfully updated !"
      redirect_to gossip_path(@gossip.id)
    else
      @alert = true
      @message = "Error: " + @gossip.errors.messages.to_a.flatten[1]
      render "edit"
    end
  end


  def destroy
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to gossip_path(@gossip.id)
  end 






end

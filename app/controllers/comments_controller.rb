class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    authorize @comment
    if @comment.save!
      redirect_back(fallback_location: root_path)
    else
      render :workout, status: :unprocessable_entity
    end
  end

  def destroy
    if params[:workout_id].present?
      @comment = Comment.find(params[:workout_id])
    elsif params[:recipe_id].present?
      @comment = Comment.find(params[:recipe_id])
    elsif params[:post_id].present?
      @comment = Comment.find(params[:post_id])
    else
      @comment = Comment.find(params[:id]) || Comment.find(comment_params)
    end
    authorize @comment

    if @comment.destroy
      flash[:notice] = "Comment has been successfully deleted."
      redirect_back(fallback_location: root_path)
    end
  end



  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type, :user_id, :id)
  end
end

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
    @comment = Comment.find(params[:workout_id]) if params[:workout_id].present?
    @comment = Comment.find(params[:recipe_id]) if params[:recipe_id].present?
    @comment = Comment.find(params[:post_id]) if params[:post_id].present?
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment has been successfully deleted."
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type, :user_id)
  end
end

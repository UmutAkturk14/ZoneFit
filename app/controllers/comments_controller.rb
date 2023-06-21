class CommentsController < ApplicationController
  def create
    @comment = Comment.new
    authorize @comment
    if Comment.create!(comment_params)
      redirect_back(fallback_location: root_path)
    else
      render :workout, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type)
  end
end

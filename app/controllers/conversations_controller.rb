class ConversationsController < ApplicationController
  def show
    @conversation = Conversation.find(params[:id])
    authorize @conversation
  end
end

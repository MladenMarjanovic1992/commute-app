class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    recipient = User.find(params[:recipientId])
    conversation = current_user.send_message(recipient, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    redirect_to session[:search_results]
  end
end

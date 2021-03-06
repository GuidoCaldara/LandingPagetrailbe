class MessagesController < ApplicationController
  before_action :check_profile

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @run = Run.find(params[:run_id])
    @message.run = @run
    authorize @message
    if @message.save
      redirect_to @run
      flash[:notice] = "Messaggio inserito"
    else
      redirect_to @run
      flash[:notice] = "Ops, qualcosa è andato storto"
    end
  end


  def edit
    @message = Message.find(params[:id])
    authorize @message
  end

  def destroy
    @message = Message.find(params[:id])
    authorize @message
    @message.destroy
    redirect_to @message.run
    flash[:notice] = "Il messaggio è stato eliminato"

  end


  def update
    @message = Message.find(params[:id])
    authorize @message
    @message.update(message_params)
    @run = @message.run
    if @message.save
      redirect_to @run
      flash[:notice] = "Messaggio modificato"
    else
      redirect_to :edit
      flash[:notice] = "Ops, qualcosa è andato storto"
    end
  end



  def message_params
    params.require(:message).permit(:text)
  end

end

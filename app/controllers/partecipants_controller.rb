class PartecipantsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @run = Run.find(params[:run_id])
    @partecipant = Partecipant.new(user: @user, run: @run)
    authorize @partecipant
    if @partecipant.save
      redirect_to @run
      flash[:notice] = "Ti sei registrato per l'allenamento."
    else
      redirect_to @run
      flash[:alert] = "Ops, qualcosa è andato storto."
    end
  end

  def destroy
  end
end

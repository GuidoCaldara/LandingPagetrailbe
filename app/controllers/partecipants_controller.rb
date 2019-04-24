class PartecipantsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_profile

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
    @user = current_user
    @run = Run.find(params[:run_id])
    @partecipant = @run.partecipants.where(user: @user).first
    @partecipant.destroy
    redirect_to @user
    flash[:notice] = "Ti sei cancellato dall'allenamento!"

  end
end

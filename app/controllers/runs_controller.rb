class RunsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]

  def index
    if params[:user_id].present?
      @user = User.friendly.find(params[:user_id])
      @all_organized_runs = @user.organized_runs
    else
      @runs = Run.all
      render :template => "runs/list"
    end

  end

  def new
    @run = Run.new
    authorize @run
  end

  def edit
    @run = Run.find(params[:id])
    authorize @run
  end

  def create
    @run = Run.new(run_params)
    @run.user = current_user
    authorize @run
    if @run.save
      Partecipant.create(user: current_user, run: @run)
      redirect_to @run.user
      flash[:notice] = "L'allenamento è stato inserito correttamente"
    else
      render :new
    end
  end

  def update
    @run = Run.find(params[:id])
    authorize @run
    if @run.save
      redirect_to @run.user
      flash[:notice] = "L'allenamento è stato aggiornato"
    else
      render :edit
    end
  end

  def show
    @run = Run.find(params[:id])
    @message = Message.new
  end


  private

  def run_params
    params.require(:run).permit(:name, :starting_point, :starting_point_info, :distance, :elevation, :duration, :date, :description, :photo )

  end
end

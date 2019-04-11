class RunsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :runs_finder]
  before_action :check_profile

  def runs_finder
    @params = params
    @runs = Run.where("date > ?", Date.today() ).where.not(latitude: nil, longitude: nil)
    @runs = @runs.filter_by_first_date(params[:dates_range]) if params[:dates_range].present?
    @runs = @runs.filter_by_last_date(params[:dates_range]) if params[:dates_range].present? && params["dates_range"].split[2]
    @runs = @runs.near(params[:location], 20, units: :km) if params[:location].present?
    @runs = @runs.order(date: :asc)
    @markers = @runs.map do |run|
      { lat: run.latitude,
        lng: run.longitude,
        name: run.name,
        distance: run.run_distance,
        date: run.date.strftime("%m-%e-%y %H:%M")
        }
    end

    respond_to do |format|
        format.js { }
        format.html { }
    end


  end


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
    params.require(:run).permit(:name, :starting_point, :starting_point_info, :run_distance, :elevation, :duration, :date, :description, :photo )
  end


end

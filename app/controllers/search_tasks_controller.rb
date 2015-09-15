class SearchTasksController < ApplicationController
  before_action :set_search_task, only: [:show, :edit, :update, :destroy]
  before_action :set_search, only: [:index, :edit, :create, :update]

  # GET /search_tasks
  # GET /search_tasks.json
  def index
    @search_tasks = current_account.search_tasks
      .where(params.slice(:search_id))
      .paginate(page: params[:page])
  end

  # GET /search_tasks/1
  # GET /search_tasks/1.json
  def show
  end

  # GET /search_tasks/new
  def new
    @search_task = current_account.search_tasks.new(begin_at: 10.minute.from_now.to_s(:db))
  end

  # GET /search_tasks/1/edit
  def edit
  end

  # POST /search_tasks
  # POST /search_tasks.json
  def create
    @search_task = current_account.search_tasks.build(search_task_params)
    @search_task.search = @search if @search
    respond_to do |format|
      if @search_task.save
        format.html { redirect_to @search || @search_task, notice: 'Search task was successfully created.' }
        format.json { render :show, status: :created, location: @search_task }
      else
        format.html { render :new }
        format.json { render json: @search_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /search_tasks/1
  # PATCH/PUT /search_tasks/1.json
  def update
    respond_to do |format|
      if @search_task.update(search_task_params)
        format.html { redirect_to (@search || @search_task), notice: 'Search task was successfully updated.' }
        format.json { render :show, status: :ok, location: @search_task }
      else
        format.html { render :edit }
        format.json { render json: @search_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /search_tasks/1
  # DELETE /search_tasks/1.json
  def destroy
    @search_task.destroy
    respond_to do |format|
      format.html { redirect_to (@search || search_tasks_url), notice: 'Search task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search_task
      @search_task = SearchTask.find(params[:id])
    end

    def set_search
      if params[:search_id].present?
        @search = Search.find params[:search_id]
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_task_params
      params.require(:search_task).permit(:search_id, :frequency_id, :begin_at, :name)
    end
end

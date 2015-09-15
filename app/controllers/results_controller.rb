class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]
  before_action :search_for_q, only: :index

  # GET /results
  # GET /results.json
  def index
    if params[:query].present?
      @results = @results.search_full_text(params[:query])
    end

    # default sort
    @results = @results.order(id: :desc)
  end

  # GET /results/1
  # GET /results/1.json
  def show
    if params[:flag] == 'modal'
      render partial: 'show_modal', locals: {result: @result}
    end
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  # POST /results.json
  def create
    @result = Result.new(result_params)

    respond_to do |format|
      if @result.save
        format.html { redirect_to @result, notice: 'Result was successfully created.' }
        format.json { render :show, status: :created, location: @result }
      else
        format.html { render :new }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to @result, notice: 'Result was successfully updated.' }
        format.json { render :show, status: :ok, location: @result }
      else
        format.html { render :edit }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url, notice: 'Result was successfully destroyed.' }
      format.json { head :no_content }
      format.js { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:search_id, :account_id, :title, :url, :domain, :description, :task_at)
    end

    def search_for_q
      @results = current_account.results.includes(:search).paginate(page: params[:page])
      if params[:sort].present?
        if params[:sort].start_with?('search')
          rs_search_ids = current_account.searches.order(
                params[:sort].split('.')[1] => params[:sort].split('.')[2] || 'asc'
              ).select(:id).map(&:id)
          @results = @results.order(rs_search_ids.map{|rs| " search_id =#{rs}"}.join(','))
        else
          @results = @results.order(
            params[:sort].split('.')[0] => params[:sort].split('.')[1] || 'asc'
            )
        end
      end
      if params[:filter].present?
        if params[:filter].start_with?('search')
          opts = params[:filter].split('-', 2)
          @results = @results.where(search_id: current_account.searches.where(
            opts[0].split('.').last => opts[-1]
          ))
        else
          opts = params[:filter].split('-', 2)
          @results = @results.where(search_id: current_account.searches.where(
            opts[0] => opts[-1]
          ))
        end
      end
    end
end

class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :edit, :update, :destroy, :run]

  # GET /searches
  # GET /searches.json
  def index
    @searches = current_account.searches
    if params[:run] == 'all'
      @searches.each{|s| s.sync_run}
    end
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
  end

  # GET /searches/new
  def new
    @search = Search.new
  end

  # GET /searches/1/edit
  def edit
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = current_account.searches.new(search_params)

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render :show, status: :created, location: @search }
      else
        format.html { render :new }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { render :show, status: :ok, location: @search }
      else
        format.html { render :edit }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url, notice: 'Search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def provider_form
    return render nothing: true unless Object.const_defined?(params[:provider])
    if params[:id]
      @search = Search.find_by(id: params[:id])
    else
      @search = Search.new provider: params[:provider]
    end
  end

  def run
    @search.sync_run
    if request.xhr?
      render js: "alert('#{t('success')}')"
    else
      redirect_to @search
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search ||= Search.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:name, :provider, :description, options: provider_params)
    end

    def provider_params
      if params[:search] && (params[:search][:provider] || set_search.try(:provider)) &&\
        Object.const_defined?(params[:search][:provider] || set_search.try(:provider))
        (params[:search][:provider] || set_search.try(:provider)).constantize.kortype_columns.keys
      else
        []
      end
    end
end

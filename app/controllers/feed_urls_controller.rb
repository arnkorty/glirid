class FeedUrlsController < ApplicationController
  before_action :set_feed_url, only: [:show, :edit, :update, :destroy, :rss, :atom]
  skip_filter :authenticate_account!, only: [:rss, :atom]

  layout false, only: [:rss, :atom]

  # GET /feed_urls
  # GET /feed_urls.json
  def index
    @feed_urls = current_account.feed_urls.paginate(page: params[:page]).order(id: :desc)
  end

  # GET /feed_urls/1
  # GET /feed_urls/1.json
  def show
  end

  # GET /feed_urls/new
  def new
    @feed_url = FeedUrl.new
  end

  # GET /feed_urls/1/edit
  def edit
  end

  # POST /feed_urls
  # POST /feed_urls.json
  def create
    @feed_url = current_account.feed_urls.new(feed_url_params)

    respond_to do |format|
      if @feed_url.save
        format.html { redirect_to feed_urls_path, notice: 'Feed url was successfully created.' }
        format.json { render :show, status: :created, location: @feed_url }
      else
        format.html { render :new }
        format.json { render json: @feed_url.errors, status: :unprocessable_entity }
      end
    end
  end

  def rss; end

  def atom; end

  # PATCH/PUT /feed_urls/1
  # PATCH/PUT /feed_urls/1.json
  def update
    respond_to do |format|
      if @feed_url.update(feed_url_params)
        format.html { redirect_to feed_urls_path, notice: 'Feed url was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed_url }
      else
        format.html { render :edit }
        format.json { render json: @feed_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feed_urls/1
  # DELETE /feed_urls/1.json
  def destroy
    @feed_url.destroy
    respond_to do |format|
      format.html { redirect_to feed_urls_url, notice: 'Feed url was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed_url
      @feed_url = FeedUrl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_url_params
      params.require(:feed_url).permit(:name, :description, :limit, :is_open, :search_ids => [])
    end
end

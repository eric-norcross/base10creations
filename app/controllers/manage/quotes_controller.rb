class Manage::QuotesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  # GET /quotes
  def index
    @quotes = Quote.all
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes
  def create
    @quote = Quote.new(quote_params)

    if @quote.save
      redirect_to edit_manage_quote_path(@quote), notice: 'Quote was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /quotes/1
  def update
    if @quote.update(quote_params)
      redirect_to edit_manage_quote_path(@quote), notice: 'Quote was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /quotes/1
  def destroy
    @quote.destroy
    redirect_to manage_quotes_url, notice: 'Quote was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def quote_params
      params.require(:quote)
        .permit(
          :author,
          :content
        )
    end
end

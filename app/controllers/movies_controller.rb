class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  @@last_title_order = ""
  @@last_rating_order = ""
  @@last_date_order = ""
  # GET /movies or /movies.json
  def index
    if params[:sort_by] == "title"
      if params[:order] == @@last_title_order
        @@last_title_order = "DESC"
        @title_color = '#00d1ff'
        @movies = Movie.order("title DESC")
      else
        @@last_title_order = params[:order]
        @title_color = '#ffc000'
        @movies = Movie.order(params[:sort_by])
      end
      @@last_rating_order = ""
      @@last_date_order = ""
      @rating_color = '#c0c0c0'
      @date_color = '#c0c0c0'
    elsif params[:sort_by] == "rating"
      if params[:order] == @@last_rating_order
        @@last_rating_order = "DESC"
        @rating_color = '#00d1ff'
        @movies = Movie.order("rating DESC")
      else
        @@last_rating_order = params[:order]
        @rating_color = '#ffc000'
        @movies = Movie.order(params[:sort_by])
      end
      @title_color = '#c0c0c0'
      @date_color = '#c0c0c0'
      @@last_title_order = ""
      @@last_date_order = ""
    elsif params[:sort_by] == "release_date"
      if params[:order] == @@last_date_order
        @@last_date_order = "DESC"
        @date_color = '#00d1ff'
        @movies = Movie.order("release_date DESC")
      else
        @@last_date_order = params[:order]
        @date_color = '#ffc000'
        @movies = Movie.order(params[:sort_by])
      end
      @title_color = '#c0c0c0'
      @rating_color = '#c0c0c0'
      @@last_rating_order = ""
      @@last_title_order = ""
    else
      @movies = Movie.order(params[:sort_by])
    end
  end

  # GET /movies/1 or /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy!

    respond_to do |format|
      format.html { redirect_to movies_url, notice: "Movie was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
end

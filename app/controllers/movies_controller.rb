class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index    
    # Declare Varibles from Movies and Params
    @all_ratings = Movie.all_ratings  
    @ratings = params[:ratings]
    @sorted = params[:sorted]
    
    # Saves the session cookies for params[:ratings]
    if (params[:sorted] != nil)
      @sorted = params[:sorted]
      session[:sorted] = @sorted
    elsif (session[:sorted] != nil)
      @sorted = session[:session]
    else
      @sorted = nil
    end
    
    #Saves the session cookies for params[:ratings]
    if (params[:ratings] != nil)
      @ratings = params[:ratings]
      session[:ratings] = @ratings
    elsif (session[:ratings] != nil)
      @ratings = session[:ratings]
    else
      @ratings = nil
    end
    
    # Makes @ratings a new hash and fills key with each @all_rating and value as 1.
    if (@ratings == nil)
      @ratings = Hash.new
      @all_ratings.each do |rating|
        @ratings[rating] = 1
      end
    end
    @ratings_to_show = @ratings
    
    # Makes sure page loads correctly depending on params: ratings & sorted
    if (@sorted != nil && @ratings != nil)
      @movies = Movie.with_ratings_sorted(@ratings, @sorted)
    elsif (@ratings != nil)
      @movies = Movie.with_ratings(@ratings)
    elsif (@sorted != nil)
      @movies = Movie.all.order(@sorted)
    else
      @movies = Movie.all 
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end

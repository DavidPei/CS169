class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #creating filter hash
    @all_ratings = Movie.get_all_ratings
    if session[:haschecked] == nil
      session[:ratings] = {'G'=>1, 'PG'=>1, 'PG-13'=>1, 'R'=>1}
    end
    if params[:ratings] != nil
      session[:ratings] = params[:ratings]
      session[:haschecked] = true
    end
    @ratings_filter = session[:ratings].keys

    #sorting and filtering
    sortBy = params[:sortBy]
    if sortBy == 'title'
      @movies = Movie.find(:all, :conditions => {:rating => @ratings_filter}, :order => sortBy.to_s)
    elsif sortBy == 'release_date'
      @movies = Movie.find(:all, :conditions => {:rating => @ratings_filter}, :order => sortBy.to_s)
    else
      @movies = Movie.find(:all, :conditions => {:rating => @ratings_filter})
    end
    @hilite = true

    return @movies

  end

  def new
  # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end


end
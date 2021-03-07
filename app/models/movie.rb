class Movie < ActiveRecord::Base
  
  # Sets all ratings
  def self.all_ratings
    return ['G','PG','PG-13','R']
  end
  
  # Calls sql query returns keys of the parameters passed
  def self.with_ratings(ratings_list)
    return where(rating: ratings_list.keys)
  end
  
  # Calls sql query returns like above with extra sorting
  def self.with_ratings_sorted(ratings_list, sorted)
    return where(rating: ratings_list.keys).order(sorted)
  end   
  
end

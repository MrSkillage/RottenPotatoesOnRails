class Movie < ActiveRecord::Base
  
  def self.all_ratings
    return ['G','PG','PG-13','R']
  end
  
  def self.with_ratings(ratings_list)
    return where(rating: ratings_list.keys)
  end
  
  def self.with_ratings_sorted(ratings_list, sorted)
    return where(rating: ratings_list.keys).order(sorted)
  end   
  
end

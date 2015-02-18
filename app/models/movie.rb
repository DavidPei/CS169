class Movie < ActiveRecord::Base
  attr_accessible :description, :rating, :release_date, :title

  def self.get_all_ratings
  	return ['G','PG','PG-13','R']
  end

end

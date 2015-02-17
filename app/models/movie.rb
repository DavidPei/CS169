class Movie < ActiveRecord::Base
  attr_accessible :description, :rating, :release_date, :title
end

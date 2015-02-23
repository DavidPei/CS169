# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
end

When /^(?:|I )press (.*)/ do |button|
  click_button(button)
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list = rating_list.split(", ")
  rating_list.each do |rating|
    id_str = "ratings_" + rating
    if uncheck
      uncheck(id_str)
    else
      check(id_str)
    end
  end
end

Then /I should (not )?see movies with these ratings: (.*)/ do |not_see, ratings|
  ratings = ratings.split(", ")
  movies = Movie.where('rating in (?)',)
  movies.each do |movie|
    if not_see
      step "I should not see \"#{movie.title}\""
    else
      step "I should see \"#{movie.title}\""
    end
  end
end

Then /I should see all the movies/ do
  movies = Movie.find(:all)
  movies.each do |movie|
    step "I should see \"#{movie.title}\""
  end
end
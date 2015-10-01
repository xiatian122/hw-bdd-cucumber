# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    #puts movie
    Movie.create(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #flunk "Unimplemented"
  page.body.index(e1).should < page.body.index(e2)
end

Then /^(?:|I )should see all of the movies/ do
  #assert(false, page.html)
  #assert find("tbody").find("tr").should == Movie.count
  #if page.respond_to? :should
  #  assert page.should have_xpath('//tbody/tr', :count => Movie.count)
  #else
  #  assert page.has_xpath('//tbody/tr', :count => Movie.count)
  #end
  page.body.scan(/<tr>/).length.should equal(Movie.all.length + 1)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  #puts uncheck
  ratings = rating_list.split(", ")
  ratings.each do |rating|
    if uncheck
      step "I uncheck \"ratings_" + rating + "\""
    else
      step "I check \"ratings_" + rating + "\""
    end
 end
end
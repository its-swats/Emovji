class Recommendation < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  belongs_to :movie
end

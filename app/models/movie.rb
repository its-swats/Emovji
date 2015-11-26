class Movie < ActiveRecord::Base
  # Remember to create a migration!
  has_many :recommendations
  has_many :recommenders, class_name: "User", through: :recommendations, source: :user



end

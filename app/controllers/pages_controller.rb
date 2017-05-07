class PagesController < ApplicationController
  # get request for / which is our home page
  def home
    @fan_plan = Plan.find(1)
    @supporter_plan = Plan.find(2)
  end
  
  def about
  end
end
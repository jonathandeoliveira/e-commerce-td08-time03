class CategoriesController < ApplicationController
  before_action :authenticate_merchant!, only: [:index]
  
  def index
    @categories = Category.all
  end
end
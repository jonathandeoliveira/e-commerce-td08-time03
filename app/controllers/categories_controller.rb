class CategoriesController < ApplicationController
  before_action :authenticate_merchant!, only: %i[index new create]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: 'Categoria criada com sucesso'
    else
      flash.now[:notice] = 'Falha ao criar categoria'
      render 'new'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def check_merchant
    return redirect_to root_path, alert: 'Você não possui acesso' unless merchant_signed_in?
  end
end

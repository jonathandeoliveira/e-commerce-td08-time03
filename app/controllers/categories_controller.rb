class CategoriesController < ApplicationController
  before_action :authenticate_merchant!

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

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path, notice: 'Categoria atualizada com sucesso.'
    else
      flash.now[:notice] = 'Falha ao atualizar categoria.'
      render 'edit'
    end
  end

  def disable
    @category = Category.find(params[:id])
    @category.disabled!
    redirect_to categories_path, notice: "Categoria #{@category.name} desativada com sucesso."
  end

  def enable
    @category = Category.find(params[:id])
    @category.enabled!
    redirect_to categories_path, notice: "Categoria #{@category.name} ativada com sucesso."
  end

  def show
    @category = Category.find(params[:id])
    @sub_categories = @category.sub_categories
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def check_merchant
    return redirect_to root_path, alert: 'Você não possui acesso' unless merchant_signed_in?
  end
end

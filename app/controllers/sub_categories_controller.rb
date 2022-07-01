class SubCategoriesController < ApplicationController
  before_action :authenticate_merchant!, except: :search

  def search
    @select = params["query"]
    @subcategory = SubCategory.find_by(id:@select)
    @product_models = ProductModel.where(sub_category_id:@subcategory)
  end

  def new
    @category = Category.find(params[:category_id])
    @sub_category = @category.sub_categories.new
  end

  def create
    @category = Category.find(params[:category_id])
    @sub_category = SubCategory.new(sub_category_params)
    @sub_category.category = @category
    if @sub_category.save
      redirect_to category_path(@category), notice: 'Subcategoria criada com sucesso.'
    else
      flash.now[:notice] = 'Falha ao criar subcategoria.'
      render 'new'
    end
  end

  def disable
    @category = Category.find(params[:category_id])
    @sub_category = SubCategory.find(params[:id])
    @sub_category.disabled!
    redirect_to category_path(@category), notice: "Subcategoria: #{@sub_category.name} desativada com sucesso."
  end

  def enable
    @category = Category.find(params[:category_id])
    @sub_category = SubCategory.find(params[:id])
    @sub_category.enabled!
    redirect_to category_path(@category), notice: "Subcategoria: #{@sub_category.name} ativada com sucesso."
  end

  private

  def sub_category_params
    params.require(:sub_category).permit(:name, :category_id)
  end
end

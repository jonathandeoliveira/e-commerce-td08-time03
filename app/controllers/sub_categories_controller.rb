class SubCategoriesController < ApplicationController
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

  private

  def sub_category_params
    params.require(:sub_category).permit(:name, :category_id)
  end
end

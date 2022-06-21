class ManualsController < ApplicationController
  def show
    @product_model = ProductModel.find(params[:product_model_id]).manual.find(params[:id])
    #@manual = @product_model.manual
    #send_file '/path/to.jpeg', :type => 'image/jpeg', :disposition => 'attachment'

    send_file @manual.path, :type => 'application/pdf', :disposition => 'attachment', identify: false
  en

  private

  def manual_params
    params.require(:manual).permit(:id,:product_model_id)
  end

end



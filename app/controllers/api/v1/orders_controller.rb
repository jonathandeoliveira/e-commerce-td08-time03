class Api::V1::OrdersController < ActionController::API
  before_action :params_validator

  def update_status
    order = Order.find_by(code: params[:order_code])
    status = params[:order_status]

    return render status: 404, json: { errors: 'Pedido não encontrado.' } if order.nil?
    return render status: 406, json: { errors: 'Status não é válido.' } unless %w[refused paid].include?(status)

    return render status: 201, json: { response: 'Status atualizado com sucesso'} if order.update!(status:)
  end

  private

  def params_validator
    order_code = params[:order_code]
    status = params[:order_code]
    return render status: 406, json: { errors: 'Parâmetros incorretos.' } if order_code.nil? || status.nil?
  end
end

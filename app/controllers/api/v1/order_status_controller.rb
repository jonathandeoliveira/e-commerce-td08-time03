class Api::V1::OrderStatusCOntroller < ActionController::API
  def update_status
    order = Order.find_by(code: params[:client_order][:order_code])
    status = params[:client_order][:order_status]

    raise ArgumentError 'Pedido não encontrado.' if order.nil?
    raise ArgumentError 'Pedido não encontrado.' if status != 'refused' || status != 'paid'

    order.update!(status: status)
  end
end

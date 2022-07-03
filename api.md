# Endpoints
## PATCH /api/v1/orders/update_status
Aprova ou recusa pedido
### Exemplo de requisição
```json
{
    "order_code": "ABCDEFGH1234567",
    "status": "paid"
}
```
O campo `code` deve ser preenchido com o código do pedido.
O campo `status` deve ser preenchido com um status válido: 'paid' ou 'refused' 

### Exemplo de resposta (Requisição bem-sucedida)
```json
{
  "response": "Status atualizado com sucesso"
}
```

### Exemplo de resposta (Pedido não encontrado)
```json
{
   "errors": "Pedido não encontrado."
}
```

### Exemplo de resposta (Status inválido)
```json
{
  "errors": "Status não é válido."
}
```

### Exemplo de resposta (Parâmetros incorretos)
```json
{
  "errors": "Parâmetros incorretos."
}
```

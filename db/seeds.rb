Merchant.destroy_all
ProductModel.destroy_all
Category.destroy_all
SubCategory.destroy_all
ProductPrice.destroy_all

# users
merchant = Merchant.create(name: 'Alan', email: 'alan@mercadores.com.br', password: 'password')


# categories
eletronicos = Category.create(name: 'Eletronicos', status: 0)
informatica = Category.create(name: 'Informática', status: 0)
games = Category.create(name: 'Games', status: 0)
livros = Category.create(name: 'Livros', status: 0)
eletrodomesticos = Category.create(name: 'Eletrodomésticos', status: 0)

# sub-categories
computadores = SubCategory.create(name: 'Computadores', category: eletronicos, status: 10)
computadores = SubCategory.create(name: 'Computadores', category: eletronicos, status: 10)
# users
merchant = Merchant.create(name: 'Alan', email: 'alan@mercadores.com.br', password: 'password')


# categories
eletronicos = Category.create!(name: 'Eletronicos', status: 0)
informatica = Category.create!(name: 'Informática', status: 0)
games = Category.create!(name: 'Games', status: 0)
livros = Category.create!(name: 'Livros', status: 0)
eletrodomesticos = Category.create!(name: 'Eletrodomésticos', status: 0)

# sub-categories
computadores = SubCategory.create!(name: 'Computadores', category: eletronicos)
celulares = SubCategory.create!(name: 'Celulares e Comunicação', category: eletronicos)
smartwatches = SubCategory.create!(name: 'Smartwatches', category: eletronicos)
monitores = SubCategory.create!(name: 'Monitores', category: informatica)
notebooks = SubCategory.create!(name: 'Notebooks', category: informatica)
acessorios = SubCategory.create!(name: 'Acessórios', category: informatica)
playstation = SubCategory.create!(name: 'PlayStation', category: games)
xbox = SubCategory.create!(name: 'Xbox', category: games)
nintendo = SubCategory.create!(name: 'Nintendo', category: games)
internacionais = SubCategory.create!(name: 'Livros Internacionais', category: livros)
lancamentos = SubCategory.create!(name: 'Lançamentos', category: livros)
hqs = SubCategory.create!(name: 'HQs e Mangás', category: livros)
lavadoras = SubCategory.create!(name: 'Lavadoras e Secadoras', category: eletrodomesticos)
geladeiras = SubCategory.create!(name: 'Geladeiras e Freezers', category: eletrodomesticos)
fogoes = SubCategory.create!(name: 'Fogões e Fornos', category: eletrodomesticos)

# products
iphone = ProductModel.create!(name: 'iPhone 11', brand: 'Apple', sku: 'IPHONE11-128GB', model: 'iPhone 11 Branco', description: 'iPhone 128GB desbloqueado', weight: 0.2, height: 15, width: 7.5, length: 0.8, sub_category: celulares, status: 0)
ideapad = ProductModel.create!(name: 'Notebook Lenovo Ultrafino IdeaPad', brand: 'Lenovo', sku: 'LENOVOIDEA', model: 'IdeaPad 3i i3', description: 'Notebook 15.6 Memória 8GB CPU: Core i3-10110U', weight: 2, height: 2, width: 36, length: 25, sub_category: notebooks, status: 0)
electrolux_jet_clean = ProductModel.create!(name: 'Máquina de Lavar Electrolux Essential Care', brand: 'Electrolux', sku: 'JETCLEAN13CARE', model: 'Jet & Clean', description: 'Máquina de Lavar 13kg Essential Care com cesto inox ultra filter 220V', weight: 30, height: 105.2, width: 59.1, length: 66.5, sub_category: lavadoras, status: 0)

# product-prices
iphone_preco1 = ProductPrice.create!(price: 4000.5, start_date: Date.today, end_date: 30.day.from_now, product_model: iphone)
iphone_preco2 = ProductPrice.create!(price: 3700.5, start_date: 31.day.from_now, end_date: 61.day.from_now, product_model: iphone)
iphone_preco3 = ProductPrice.create!(price: 3950.0, start_date: 62.day.from_now, end_date: 92.day.from_now, product_model: iphone)
idea_preco1 = ProductPrice.create!(price: 2800.0, start_date: Date.today, end_date: 30.day.from_now, product_model: ideapad)
idea_preco2 = ProductPrice.create!(price: 2900.0, start_date: 31.day.from_now, end_date: 61.day.from_now, product_model: ideapad)
idea_preco3 = ProductPrice.create!(price: 3400.8, start_date: 62.day.from_now, end_date: 92.day.from_now, product_model: ideapad)
jet_clean_preco1 = ProductPrice.create!(price: 2000.3, start_date: Date.today, end_date: 30.day.from_now, product_model: electrolux_jet_clean)
jet_clean_preco2 = ProductPrice.create!(price: 1760.5, start_date: 31.day.from_now, end_date: 61.day.from_now, product_model: electrolux_jet_clean)
jet_clean_preco3 = ProductPrice.create!(price: 1950.5, start_date: 62.day.from_now, end_date: 92.day.from_now, product_model: electrolux_jet_clean)
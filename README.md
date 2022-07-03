<h1 align="center">E-commerce </h1>

<div align="center"><img src="app/assets/images/readme_images/ecommerce.png"></div>

<div align="center"><img src="https://badgen.net/badge/Ruby/Versão%203.1/red?icon=ruby"> <img  align="justify" src="https://raw.githubusercontent.com/jonathandeoliveira/campus-delivery/e46c3cd2f6f684e496cf70eae6a13eae60452f7f/app/assets/images/v1.svg"> <img  align="justify" src=https://img.shields.io/badge/Status-Em%20desenvolvimento-brightgreen> </div>

____
### <p align="justify"> Tabela de Conteúdos 🗺️: </p>
  🔹	[Descrição do projeto](#descrição-do-projeto) </br>
  🔹	[Funcionalidades](#funcionalidades)</br>
  🔹	[Gems utilizadas](#gems-utilizadas)</br>
  🔹	[Como instalar a aplicação](#como-instalar-a-aplicação)</br>
  🔹	[Utilizando as API's](#utilizando-as-banco-d)</br>
  🔹	[Configurando o banco de dados](#configurando-o-banco-de-dados)</br>
  🔹	[Layout da aplicação](#layout-da-aplicação)</br>
  🔹	[Ideias para implementações futuras](#ideias-para-implementações-futuras)</br>

  #### <p align="justify"> Descrição do projeto </p>
___
  Uma plataforma que permite a compra de produtos em uma loja virtual
  utilizandopagamentos através de pontos chamados Rubis, que podem ser acumulados pelas pessoas. Os Rubis são creditados na conta através de pagamentos convencionais e seu preço é dado por uma taxa de cambio flutuante.

  #### <p align="justify"> Funcionalidades da aplicação </p>
___

  - [X] Administrador da loja consegue cadastrar produtos, categorias e subcategorias de produtos.
  - [x] Administrador da loja consegue ativar ou desativar produtos, categorias e subcategorias de produtos.
  - [X] Administrador consegue realizar o acompanhamento de pedidos.
  - [X] Administrador consegue programar valores de produtos por intervalos de datas.
  - [x] Administrador consegue cadastrar um cupom de promoção para subcategorias selecionadas com valor percentual, valor máximo em dinheiro e quantidade máxima de usos e data de expiração.
  - [X] Visitante pode ver todos os produtos, buscar produtos por categoria ou por nome e se cadastrar na plataforma.
  - [X] Cliente pode adicionar produtos ao carrinho
  - [X] Cliente pode inserir um cupom de desconto 
  - [X] Cliente pode acompanhar a situação de suas compras
  - [X] Cliente pode ver detalhes de suas compras
  - [X] Cliente pode conferir seus dados e realizar a compra de Rubis

 ##### <p align="justify"> Linguagem e Gems utilizadas :gem:: </p>
___
- [Ruby 3.1](https://ruby-doc.org) - Linguagem utilizada
- [Rails 7.0](https://guides.rubyonrails.org) - Framerwork utilizado para desenvolver o projeto
- [Rspec](https://github.com/rspec/rspec-rails) - Utilizado para os testes da aplicação
- [Capybara](https://github.com/teamcapybara/capybara#using-capybara-with-rspec) -Auxilia o rspec durante os testes
- [Devise](https://github.com/heartcombo/devise) -	Utiliziada para gerenciamento dos usuários
- [Pry-byebug](https://github.com/deivid-rodriguez/pry-byebug) - Utilizada para debugar o código
- [Simplecov](https://github.com/simplecov-ruby/simplecov) - Utilizada para garantir que os testes cubram o máximo de código possível 
- [Shoulda-Matchers](https://github.com/thoughtbot/shoulda-matchers) - Utilizada para facilitar testes de validações de models
- [Factory-Bot](https://github.com/thoughtbot/factory_bot) - Utilizado para facilitar a criação de objetos no ambiente de testes
- [Faker](https://github.com/faker-ruby/faker-bot) - Utilizada em conjunto ao factory-bot
- [Rubocop](https://github.com/rubocop/rubocop-rails) - Utilizado para padronização de código

####  <p align="justify"> Como instalar a aplicação 🔌: </p>
___

Clone o repositório em seu computador: 

    $ git clone  https://github.com/TreinaDev/e-commerce-td08-time03.git 

######  <p align="justify"> Instale as dependências do projeto: </p>

    $ bundle install

###### Inicie o servidor:

    $ rails server

###### Rodando os testes:

    rspec

#### Configurando banco de dados 💾:
___

Execute o comando seed no seu console para popular o banco de dados:

    rails db:seed


#### Utilizando as API's 🛸:
___

 - A aplicação pode ser utilizada sem o uso da API [pagamentos](https://github.com/TreinaDev/pagamentos-td08-time03), desenvolvida por outro grupo do nosso time, mas recomendamos que ela seja utilizada em conjunto com a nossa. Veja o repositório deles para mais detalhes de uso e instalação. 
 - Nossa aplicação também possui endpoints para receber requisições, que estão disponíveis no arquivo api.md

###### Inicializando a aplicação de pagamentos:
Com a aplicação de pagamentos pronta para uso, utilizaremos ela simultâneamente com a nossa, através da porta 4000 </br>

    $ rails server -p 4000

#### Layout da aplicação 🔭:
___
###### Como mercador:
  <img src="app/assets/images/readme_images/category_details.jpg">
  <img src="app/assets/images/readme_images/category_list_merchant.jpg">
  <img src="app/assets/images/readme_images/create_product.jpg">
  <img src="app/assets/images/readme_images/promotion_create_merchant.jpg">
  <img src="app/assets/images/readme_images/promotion_list_merchant.jpg"></br>
  <img src="app/assets/images/readme_images/product_list_merchant.jpg">
  <img src="app/assets/images/readme_images/order_list_merchant.jpg">

###### Como visitante/cliente:
  <img src="app/assets/images/readme_images/customer_account.jpg">
  <img src="app/assets/images/readme_images/ruby_buy.jpg">
  <img src="app/assets/images/readme_images/customer_product_detail.jpg">
  <img src="app/assets/images/readme_images/customer_cart.jpg">
  <img src="app/assets/images/readme_images/cupom_field.jpg">

###### Páginas compartilhadas:
  <img src="app/assets/images/readme_images/homepage1.jpg">
  <img src= "app/assets/images/readme_images/login_screen.jpg">
  <img src="app/assets/images/readme_images/search_product.jpg">

### Ideias para implementações futuras 📖:
___
* Utilização da Gem FriendlyId para urls personalizadas
* Melhorar o front-end da aplicação
* Melhoria no sistema de cupons
* Implementação sistema de cashback
* Implementação de estoque de produtos

### Contribuintes 👨‍💻👩‍💻 : 

| [<img src="https://avatars.githubusercontent.com/u/56161566?v=4v" width=115><br><sub>Jonathan de Oliveira Gonçalves</sub>](https://github.com/jonathandeoliveira) |  [<img src="https://avatars.githubusercontent.com/u/28884110?v=4" width=115><br><sub>Raif Cerveny</sub>](https://github.com/Raifc) |  [<img src="https://avatars.githubusercontent.com/u/83035492?v=4" width=115><br><sub>Margarete Freitas Martins</sub>](https://github.com/fmarga) |  [<img src="https://avatars.githubusercontent.com/u/43433070?v=4" width=115><br><sub>Lucas César</sub>](https://github.com/lucascda) |
| :---: | :---: | :---: | :---: | 
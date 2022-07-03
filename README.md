<h1 align="center">E-commerce </h1>
<div align= "center">
<div align="center">
 <img src="https://cdn-icons.flaticon.com/png/512/3051/premium/3051772.png?token=exp=1656826761~hmac=1362dcd9efd41893fd27326fab2db0da"   >  
 </div>
<img src="https://badgen.net/badge/Ruby/Versão%203.1/red?icon=ruby"> <img  align="justify" src="https://raw.githubusercontent.com/jonathandeoliveira/campus-delivery/e46c3cd2f6f684e496cf70eae6a13eae60452f7f/app/assets/images/v1.svg"> <img  align="justify" src=https://img.shields.io/badge/Status-Em%20desenvolvimento-brightgreen> 

</div>

### <p align="justify"> Tabela de Conteúdos 🗺️: </p>
  🔹	[Descrição do projeto](#descrição-do-projeto) 
  🔹	[Funcionalidades](#funcionalidades)
  🔹	[Gems utilizadas](#gems-utilizadas)
  🔹	[Como instalar a aplicação](#como-instalar-a-aplicação)
  🔹	[Utilizando a API de pagamentos](#configurando-o-banco-de-dados)
  🔹	[Configurando o banco de dados](#configurando-o-banco-de-dados)
  🔹	[Layout da aplicação 📸](#layout-da-aplicação)
  🔹	[Ideias para implementações futuras](#ideias-para-implementações-futuras)</br>

#### <p align="justify"> Descrição do projeto </p>
Uma plataforma que permite a compra de produtos em uma loja virtual
utilizandopagamentos através de pontos chamados Rubis, que podem ser acumulados pelas pessoas. Os Rubis são creditados na conta através de pagamentos convencionais e seu preço é dado por uma taxa de cambio flutuante.



#### <p align="justify"> Funcionalidades da aplicação </p>

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



 ##### Linguagem e Gems utilizadas :gem::

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

#### Como instalar a aplicação 🔌:

Clone o repositório em seu computador: 

    $ git clone  https://github.com/TreinaDev/e-commerce-td08-time03.git 

###### Instale as dependências do projeto:

    $ bundle install

###### Inicie o servidor:

    $ rails server

###### Rodando os testes:

    rspec




#### Configurando banco de dados 💾:
Execute o comando seed no seu console para popular o banco de dados:

    rails db:seed


#### Layout da aplicação:
<img src="">
<img src= "">
<img src="">
<img src="">


### Ideias para implementações futuras 📖:
* Utilização da Gem FriendlyId para urls personalizadas
* Melhorar o front-end da aplicação
* Implementar sistema de cashback

### Contribuintes 👨‍💻👩‍💻 : 

| [<img src="https://avatars.githubusercontent.com/u/56161566?v=4v" width=115><br><sub>Jonathan de Oliveira Gonçalves</sub>](https://github.com/jonathandeoliveira) |  [<img src="https://avatars.githubusercontent.com/u/28884110?v=4" width=115><br><sub>Raif Cerveny</sub>](https://github.com/Raifc) |  [<img src="https://avatars.githubusercontent.com/u/83035492?v=4" width=115><br><sub>Margarete Freitas Martins</sub>](https://github.com/fmarga) |  [<img src="https://avatars.githubusercontent.com/u/43433070?v=4" width=115><br><sub>Lucas César</sub>](https://github.com/lucascda) |
| :---: | :---: | :---: | :---: | 
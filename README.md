# Octo Events API v1.0

Octo Events é um aplicativo que escuta Github Events via webhooks e expõe por uma API para uso posterior.

## Environment

ruby '3.1.2'
rails '7.0.4'
Base de Dados PostgreSQL

## Instalação e Configuração

### Instalando as Gems:  

```
bundle install
```

### Criando a Base de Dados

Configurar em `config/database.yml` usuário e senha local da base de dados.

- `rails db:create db:migrate`

- `rails s -p 3000 -b '0.0.0.0'`

### Criando o Webhook

1) No repositório especifico do Github, acesse `Settings > Webhooks`  
2) Selecionar `Add webhook`  
3) Em `Payload URL` incluir a URL da API para o Endpoint de Payload. No caso: `{base_url}/events`  
4) Definir `Content-Type` como `application/json`  
5) Selectionar `Let me select individual events` e Escolher `Issues` & `Issue comments`  
6) Marcar Active no checkbox  
7) Clicar em `Add Webhook`  

Obs: Para testar o funcionamento do webhook em ambiente de desenvolvimento local, foi utilizado o `ngrok` (https://ngrok.com/).  
Para tal, basta instalar o ngrok seguindo as instruções de acordo com o ambiente de desenvolvimento e:  
1) Colocar para rodar na porta sendo utilizada pelo projeto (neste projeto, a porta 3000): `ngrok http 3000`
2) Obter a URL disponibilizada pelo `ngrok` e utilizá-la como `Payload URL` na configuração do Passo 3.

## Rodando o Projeto

```
rails server
```

## Testes

Testes com RSpec

### Criando Base de Testes

```
rails db:create RAILS_ENV=test
```
```
rails db:migrate RAILS_ENV=test
```

### Rodando Testes

```
bundle exec rspec
```

## Documentação

| HTTP | Rota | Descrição |
| ----------- | ---- | --------- |
| **POST** | /events | Webhook que recebe eventos do Github e os armazena na Base de Dados (apenas configurado no repositório do github) |
| **GET** | /issues/{issue_number}/events | Lista de eventos filtrados pelo número do issue |

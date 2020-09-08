# API

A API é responsável por ser o "elo" entre o banco de dados e o mobile.

## Instalação
- `npm i` para instalar os pacotes necessários
- Alterar o arquivo `.env` e `.env.prod` e inserir as informações de conexão do banco
- Criar a variável de ambiente `GOOGLE_APPLICATION_CREDENTIALS` que aponte para o arquivo json referente ao firebase admin sdk

## Execução
- `npm run start:dev` para rodar em modo de desenvolvimento
- `npm run build && npm run start:prod` para compilar e executar a aplicação para produção

## Recomendações
- Não deixe informações sensíveis no env.prod. Ao invés disso crie variáveis de ambiente
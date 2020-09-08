# Extrator

O extrator é responsável por ficar extraindo periodicamente mangás do https://leitor.net/

## Instalação
- `npm i` para instalar os pacotes necessários
- Alterar o arquivo `ormconfig.json` e inserir as informações de conexão do banco
- Criar a variável de ambiente `GOOGLE_APPLICATION_CREDENTIALS` que aponte para o arquivo json referente ao firebase admin sdk

## Execução
- `npm run start:dev` para rodar em modo de desenvolvimento
- `npm run build && npm start` para compilar a aplicaçaõ, gerando código javascript, e então executar o código javascript

## Recomendações
- Não deixe informações sensíveis no ormconfig.json. Ao invés disso crie variáveis de ambiente
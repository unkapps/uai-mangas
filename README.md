
# Uai Mangás

Percebendo poucas opções de aplicativos Android para leitura de mangás no Brasil e tendo vontade de experimentar algumas tecnologias surgiu este projeto.

Seu funcionamento acontece da seguinte forma:
- Através do [extrator](https://github.com/unkapps/uai-mangas/tree/master/extrator) é obtido, automaticamente, mangás do site [https://leitor.net/](https://leitor.net/). Ele também é responsável por disparar eventos para o Firebase Cloud Messaging.
- Através da [api](https://github.com/unkapps/uai-mangas/tree/master/api) acontece toda a comunicação com o banco de dados: autenticação do usuário, busca por um mangá, listagem de um mangá e etc.
- Através do [mobile](https://github.com/unkapps/uai-mangas/tree/master/mobile) está a camada de apresentação.

**Descrição do Google Play**
```
Leia + de 7000 de mangás em PORTUGUÊS diretamente pelo seu celular.
Uai Mangás foi criado com muito amor de fã para fãs para possibilitar a fácil leitura de scans.

Modo de leitura
- Vertical, igual webtoon (padrão)
- Horizontal

Funcionalidades:
- Adicionar mangá como favorito;
- Busca por nome no acervo de + de 7000 mangás;
- Receber notificação no lançamento de um novo capitulo!
```

## Screenshots
![ss](https://github.com/unkapps/uai-mangas/blob/master/mobile/images_src/ss/multiple.jpg)

## Tecnologias

### Extrator
- NodeJS
- TypeORM
- Typescript
- ESLint

### Api
- NodeJS
- NestJS
- TypeORM
- Typescript
- Firebase
- ESLint

### Mobile
- Flutter
- Firebase
- Mobx
- Pedantic

## Instalação
- [extrator](https://github.com/unkapps/uai-mangas/tree/master/extrator) 
- [api](https://github.com/unkapps/uai-mangas/tree/master/api) 
- [mobile](https://github.com/unkapps/uai-mangas/tree/master/mobile)

## O que não foi feito

O projeto foi realizado apenas para diversão e treinamento de algumas tecnologias e por isso alguns tópicos importantes não foram implementados, entre eles:
- Testes unitários
- Padronização arquitetural nos projetos extrator/Api
- Bugs
	- [Bug  7](https://github.com/unkapps/uai-mangas/issues/7)
- Documentação da API através do Swagger

## Conclusão
O projeto deixa a desejar em muitos aspectos, principalmente no extrator/api, mas acredito que consegue ter várias partes reaproveitas.

Nos divertimos muito desenvolvendo ele e torcemos para que seja útil para alguém :D

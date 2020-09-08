# Mobile

O mobile é a parte que o usuário interage :D

## Instalação
- `flutter pub get` para instalar os pacotes necessários
- Através do [console do firebase](https://console.firebase.google.com/) gerar um novo `android\app\google-services.json` caso contrário nada relacionado ao firebase funcionará
- Alterar o arquivo `lib\app\shared\config\environment_config.dart` e inserir a url do servidor
- Alterar o arquivo `android\app\src\main\res\values\strings.xml` e inserir o id da aplicação do facebook, caso contrário o login pelo facebook não funcionará

## Recomendações
- Pensar em uma forma melhor para a url do servidor, pois o environment_config.dart não está bom hahaha
- Não deixe informações sensíveis no ormconfig.json. Ao invés disso crie variáveis de ambiente
- Não commitar a chave de assinatura da aplicação
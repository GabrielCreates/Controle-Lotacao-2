# Controle de Lotação 2.0 — Gerenciamento de Acessos

## Descrição

Aplicativo desenvolvido em Flutter para gerenciar o acesso de pessoas a um ambiente, registrando entradas e saídas e acompanhando a ocupação em relação à capacidade máxima.

## Ambiente escolhido

**Academia**, com capacidade máxima de **30 pessoas**.

## Integrantes

- Gabriel Rocha de Souza — RM567023
- Murilo Marques Cabral — RM568224

## Vídeo de demonstração

[Assistir à demonstração do aplicativo no YouTube](https://youtu.be/0D_XKQYdqNo?is=VSNVRxjpZppvOe1G)

## Tecnologias e pacotes

- Flutter e Dart
- `intl` — formatação de datas e horários
- `flutter_slidable` — ações nos itens da lista
- `google_fonts` — tipografia
- `flutter_launcher_icons` — configuração do ícone do aplicativo

## Como executar

### Pré-requisitos

- Flutter SDK instalado e configurado no PATH.
- Android Studio, emulador Android ou dispositivo compatível, ou outro destino suportado pelo Flutter.

### Passos

1. Clone este repositório e entre na pasta do projeto:

   ```bash
   git clone https://github.com/GabrielCreates/Controle-Lotacao-2.git
   cd Controle-Lotacao-2
   ```

2. Instale as dependências:

   ```bash
   flutter pub get
   ```

3. Opcionalmente, gere os ícones do aplicativo:

   ```bash
   dart run flutter_launcher_icons
   ```

4. Inicie o aplicativo em um dispositivo ou emulador conectado:

   ```bash
   flutter run
   ```

5. Para executar os testes automatizados:

   ```bash
   flutter test
   ```

## Estrutura do projeto

```text
lib/
├── main.dart
├── models/
│   └── pessoa.dart
├── screens/
│   └── home_page.dart
├── theme/
│   └── app_colors.dart
└── widgets/
    └── pessoa_item.dart

test/
└── widget_test.dart
```

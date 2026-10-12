# Controle de Lotação 2.0 — Gerenciamento de Acessos

## Descrição

Aplicativo Flutter que evolui o Controle de Lotação do Checkpoint 01: cadastra pessoas, controla entrada e saída e respeita a capacidade máxima.

## Ambiente escolhido

Academia (capacidade máxima: 30 pessoas).

## Integrantes

* \- Gabriel Rocha de Souza — RM567023
* \- Murilo Marques Cabral — RM568224

## Vídeo de demonstração

\https://youtu.be/0D_XKQYdqNo?is=VSNVRxjpZppvOe1G

## Como executar

1. Crie o projeto (`flutter create .`) ou use o seu e copie `lib/` e `assets/` para ele.
2. Mescle `pubspec\_trecho.yaml` no `pubspec.yaml` (ou use `flutter pub add`).
3. Execute:

```bash
flutter pub get
dart run flutter\_launcher\_icons
flutter run
```

## Tecnologias/pacotes

Flutter/Dart, intl, flutter\_slidable, google\_fonts, flutter\_launcher\_icons.

## Estrutura

```
lib/main.dart
lib/models/pessoa.dart
lib/screens/home\_page.dart
lib/widgets/pessoa\_item.dart
lib/theme/app\_colors.dart
```


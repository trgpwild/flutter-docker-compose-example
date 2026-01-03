# Flutter MobX Biometric App (Docker)

Projeto Flutter robusto configurado para rodar em containers Docker, facilitando o desenvolvimento cross-platform (Android/iOS) com foco em segurança biométrica e gerência de estado reativa.

## 🚀 Tecnologias
- **Flutter**: UI Framework.
- **MobX**: Gerenciamento de estado reativo e transparente.
- **Biometria**: Autenticação local segura via `local_auth`.
- **Docker & Docker Compose**: Ambiente de desenvolvimento padronizado.

## 🛠️ Pré-requisitos
- Docker 
- Docker Compose

## 🏃 Como Rodar

### 1. Subir o ambiente
Este comando constrói a imagem (se necessário) e inicia o container em segundo plano:
```bash
docker compose up -d
```

### 2. Rodar o App
Para iniciar a aplicação no emulador ou dispositivo conectado:
```bash
docker compose exec flutter flutter run
```

### 3. Geração de Código (MobX)
Se você fizer alterações nas stores MobX (`counter_store.dart`), rode o build_runner:
```bash
docker compose exec flutter flutter pub run build_runner build --delete-conflicting-outputs
```

## � Conectando Dispositivos

Por padrão, o container está configurado com permissões privilegiadas para acessar dispositivos USB.

### Via USB (Celular Físico)
1. Conecte o celular ao computador.
2. Certifique-se de que o **Debbuging USB** está ativo.
3. No terminal do host, rode `lsusb` para garantir que o sistema vê o aparelho.
4. Dentro do container, o Flutter deverá reconhecê-lo automaticamente em `flutter devices`.

### Via Rede (Emulador no Host)
Se você usa um emulador rodando no seu computador (fora do Docker):
1. No seu computador (host): `adb tcpip 5555`.
2. Descubra o IP do host na rede docker: `ip addr show docker0`.
3. No container: `adb connect <IP_DO_HOST>:5555`.

## �📁 Estrutura do Projeto
- `lib/store/`: Gerenciamento de estado (MobX).
- `lib/services/`: Lógica de biometria e integrações.
- `lib/pages/`: UI (AuthPage e HomePage).
- `Dockerfile`: Configuração do ambiente com Android SDK e Flutter SDK.

## 📱 Configurações Mobile

### Android
O projeto já inclui:
- Permissão `USE_BIOMETRIC` no `AndroidManifest.xml`.
- `MainActivity` herdando de `FlutterFragmentActivity` para suporte a prompts de biometria.

### iOS
Para habilitar biometria no iOS, adicione ao seu `Info.plist`:
```xml
<key>NSFaceIDUsageDescription</key>
<string>Por favor, autentique-se para acessar o aplicativo.</string>
```

---
Desenvolvido como um exemplo de arquitetura moderna e segura.

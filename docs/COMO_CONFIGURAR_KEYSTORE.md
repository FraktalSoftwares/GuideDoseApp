# Como Configurar o Keystore para Assinar APK Release

## Informações Necessárias

Para criar o arquivo `android/key.properties`, você precisa de:

1. **storeFile**: Caminho do arquivo keystore (ex: `app/m-c-guide-dose-0vlmcq-keystore.jks`)
2. **storePassword**: Senha do keystore
3. **keyAlias**: Nome do alias da chave dentro do keystore
4. **keyPassword**: Senha da chave (pode ser a mesma do storePassword)

## Opção 1: Obter Informações do Keystore Existente

Se você já tem o keystore (`m-c-guide-dose-0vlmcq-keystore.jks`) mas não lembra das informações:

### Passo 1: Listar os aliases do keystore

Abra o PowerShell ou CMD e execute:

```powershell
cd F:\GuideDoseApp\android\app
keytool -list -v -keystore m-c-guide-dose-0vlmcq-keystore.jks
```

Quando pedir a senha, digite a senha do keystore. Isso mostrará:
- Os aliases disponíveis (você precisa do nome do alias)
- Informações sobre o certificado

### Passo 2: Criar o arquivo key.properties

Depois de obter as informações, crie o arquivo `android/key.properties`:

```properties
storePassword=SUA_SENHA_DO_KEYSTORE
keyPassword=SUA_SENHA_DA_CHAVE
keyAlias=NOME_DO_ALIAS
storeFile=app/m-c-guide-dose-0vlmcq-keystore.jks
```

**Importante**: 
- O caminho `storeFile` é relativo à pasta `android/`
- Se você não lembra da senha, não é possível recuperá-la - você precisará criar um novo keystore

## Opção 2: Criar um Novo Keystore

Se você não tem as informações do keystore existente ou quer criar um novo:

### Passo 1: Criar o keystore

```powershell
cd F:\GuideDoseApp\android\app
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Você será solicitado a informar:
- Senha do keystore (guarde bem!)
- Seus dados (nome, organização, etc.)
- Senha da chave (pode ser a mesma do keystore)

### Passo 2: Criar o arquivo key.properties

Crie o arquivo `android/key.properties`:

```properties
storePassword=senha_que_você_definiu
keyPassword=senha_que_você_definiu
keyAlias=upload
storeFile=app/upload-keystore.jks
```

## Opção 3: Usar o Keystore Existente (Se Você Lembra das Informações)

Se você lembra das informações do keystore `m-c-guide-dose-0vlmcq-keystore.jks`:

1. Crie o arquivo `android/key.properties` com:

```properties
storePassword=SUA_SENHA
keyPassword=SUA_SENHA
keyAlias=NOME_DO_ALIAS
storeFile=app/m-c-guide-dose-0vlmcq-keystore.jks
```

2. Substitua:
   - `SUA_SENHA` pela senha do keystore
   - `NOME_DO_ALIAS` pelo nome do alias (provavelmente algo como `upload` ou `key0`)

## Verificar se Está Configurado Corretamente

Depois de criar o `key.properties`, execute:

```powershell
flutter build apk --release
```

Se estiver configurado corretamente, você verá:
```
✓ Keystore configurado: [caminho]
✓ Assinatura aplicada ao build release
```

## Segurança

⚠️ **IMPORTANTE**: 
- O arquivo `key.properties` está no `.gitignore` e NÃO deve ser commitado no Git
- Guarde as senhas em local seguro
- Se perder o keystore ou as senhas, não será possível atualizar o app na Play Store com o mesmo nome

## Próximos Passos

Depois de configurar o `key.properties`:
1. Execute `flutter build apk --release`
2. O APK será assinado corretamente
3. Você poderá instalar o APK sem erros

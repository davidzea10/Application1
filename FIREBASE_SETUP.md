# Configuration Firebase - Instructions

## Étape 1 : Créer un projet Firebase

1. Aller sur [Firebase Console](https://console.firebase.google.com/)
2. Cliquer sur "Ajouter un projet"
3. Entrer le nom du projet (ex: "application1")
4. Suivre les étapes de configuration

## Étape 2 : Configurer Android

1. Dans Firebase Console, aller dans "Paramètres du projet" (icône engrenage)
2. Cliquer sur "Ajouter une application" et sélectionner Android
3. Entrer le nom du package : `com.example.application1`
4. Télécharger le fichier `google-services.json`
5. **Placer le fichier dans** : `android/app/google-services.json`

## Étape 3 : Configurer iOS

1. Dans Firebase Console, aller dans "Paramètres du projet"
2. Cliquer sur "Ajouter une application" et sélectionner iOS
3. Entrer le Bundle ID : **`com.example.application1`** (trouvé dans `ios/Runner.xcodeproj/project.pbxproj`)
4. Télécharger le fichier `GoogleService-Info.plist`
5. **Placer le fichier dans** : `ios/Runner/GoogleService-Info.plist`
6. Ouvrir `ios/Runner.xcworkspace` dans Xcode
7. Glisser-déposer le fichier `GoogleService-Info.plist` dans le projet Runner

## Étape 4 : Activer l'authentification dans Firebase

### 4.1 Accéder à la section Authentication

1. **Ouvrir Firebase Console** : Aller sur [https://console.firebase.google.com/](https://console.firebase.google.com/)
2. **Sélectionner votre projet** : Cliquer sur le nom du projet que vous avez créé
3. **Accéder à Authentication** : Dans le menu de gauche, cliquer sur "Authentication" (ou "Authentification" en français)
4. **Démarrer** : Si c'est la première fois, vous verrez un bouton "Commencer" ou "Get started" - Cliquer dessus

### 4.2 Activer Email/Password (Authentification par email/mot de passe)

1. **Onglet "Sign-in method"** : Une fois dans Authentication, cliquer sur l'onglet "Sign-in method" (Méthodes de connexion)
2. **Trouver Email/Password** : Dans la liste des providers, chercher "Email/Password" (ou "Email/Mot de passe")
3. **Activer** : Cliquer sur "Email/Password"
4. **Activer le toggle** : Dans la fenêtre qui s'ouvre, activer le premier toggle "Enable" (Activer)
5. **Sauvegarder** : Cliquer sur "Save" (Enregistrer)
6. **Vérification** : Vous devriez voir "Email/Password" avec un statut "Enabled" (Activé) dans la liste

**Note** : Cette méthode permet aux utilisateurs de s'inscrire et se connecter avec leur email et mot de passe.

### 4.3 Activer les providers OAuth

Pour chaque provider OAuth, vous devez :
1. Cliquer sur le provider dans la liste
2. Activer le toggle "Enable"
3. Configurer les informations requises (voir détails ci-dessous)
4. Sauvegarder

---

## Étape 5 : Configurer les providers OAuth en détail

### 5.1 Google Sign-In (Connexion Google)

#### Configuration dans Firebase Console :

1. **Activer Google** :
   - Dans "Sign-in method", cliquer sur "Google"
   - Activer le toggle "Enable"
   - **Project support email** : Entrer votre email (ex: votre-email@gmail.com)
   - Cliquer sur "Save"

2. **Obtenir le SHA-1 pour Android** (OBLIGATOIRE pour Android) :
   - Voir la section "Obtenir le SHA-1" ci-dessous
   - Une fois le SHA-1 obtenu, aller dans Firebase Console > Paramètres du projet (icône engrenage)
   - Cliquer sur "Vos applications" > Sélectionner votre app Android
   - Cliquer sur "Ajouter une empreinte" et coller le SHA-1
   - Sauvegarder

3. **Vérification** :
   - Le provider Google devrait apparaître comme "Enabled" dans la liste

**Note** : Pour iOS, aucune configuration supplémentaire n'est nécessaire si vous avez déjà ajouté l'app iOS dans Firebase.

---

### 5.2 Facebook Authentication (Connexion Facebook)

#### Étape 1 : Créer une application Facebook

1. **Aller sur Facebook Developers** :
   - Ouvrir [https://developers.facebook.com/](https://developers.facebook.com/)
   - Se connecter avec votre compte Facebook

2. **Créer une nouvelle app** :
   - Cliquer sur "Mes applications" (My Apps) en haut à droite
   - Cliquer sur "Créer une application" (Create App)
   - Choisir le type "Consommateur" (Consumer) ou "Aucun" (None)
   - Entrer un nom d'application (ex: "Application1 Mobile")
   - Entrer votre email de contact
   - Cliquer sur "Créer une application"

3. **Ajouter le produit Facebook Login** :
   - Dans le tableau de bord de votre app, chercher "Facebook Login"
   - Cliquer sur "Configurer" ou "Set Up"
   - Choisir "Web" comme plateforme (même pour une app mobile)
   - Entrer l'URL du site : `https://your-project.firebaseapp.com/__/auth/handler`
   - Cliquer sur "Enregistrer"

4. **Obtenir l'App ID et l'App Secret** :
   - Dans le tableau de bord, aller dans "Paramètres" > "Paramètres de base"
   - **App ID** : Copier cette valeur (ex: `1234567890123456`)
   - **App Secret** : Cliquer sur "Afficher" et copier la valeur (ex: `abcdef1234567890abcdef1234567890`)

#### Étape 2 : Configurer dans Firebase Console

1. **Dans Firebase Console** :
   - Aller dans Authentication > Sign-in method
   - Cliquer sur "Facebook"
   - Activer le toggle "Enable"

2. **Entrer les informations** :
   - **App ID** : Coller l'App ID copié depuis Facebook Developers
   - **App Secret** : Coller l'App Secret copié depuis Facebook Developers

3. **Copier l'URI de redirection OAuth** :
   - Firebase vous donnera un URI de redirection (ex: `https://your-project.firebaseapp.com/__/auth/handler`)
   - **IMPORTANT** : Copier cet URI

4. **Retourner sur Facebook Developers** :
   - Aller dans Facebook Login > Paramètres
   - Dans "URI de redirection OAuth valides", ajouter l'URI copié depuis Firebase
   - Cliquer sur "Enregistrer les modifications"

5. **Sauvegarder dans Firebase** :
   - Retourner dans Firebase Console
   - Cliquer sur "Save" (Enregistrer)

**Note** : L'URI de redirection OAuth doit être exactement le même dans Firebase et Facebook.

---

### 5.3 Twitter Authentication (Connexion Twitter)

#### Étape 1 : Créer une application Twitter

1. **Aller sur Twitter Developer Portal** :
   - Ouvrir [https://developer.twitter.com/](https://developer.twitter.com/)
   - Se connecter avec votre compte Twitter

2. **Créer un projet et une app** :
   - Si c'est votre première fois, créer un projet
   - Créer une nouvelle app dans le projet
   - Entrer un nom d'application (ex: "Application1 Mobile")
   - Remplir les informations requises

3. **Configurer les paramètres de l'app** :
   - Dans les paramètres de l'app, aller dans "App settings"
   - **App permissions** : Sélectionner "Read and write" ou "Read"
   - **Type of App** : Sélectionner "Web App, Automated App or Bot"
   - **Callback URI / Redirect URL** : Ajouter `https://your-project.firebaseapp.com/__/auth/handler`
   - **Website URL** : Ajouter `https://your-project.firebaseapp.com`
   - Cliquer sur "Save"

4. **Obtenir les clés API** :
   - Dans l'onglet "Keys and tokens"
   - **API Key** : Copier cette valeur (ex: `AbCdEf123456GhIjKl`)
   - **API Key Secret** : Cliquer sur "Regenerate" si nécessaire, puis copier (ex: `MnOpQr789012StUvWxYz345678AbCdEf`)
   - **Bearer Token** : Non nécessaire pour Firebase

#### Étape 2 : Configurer dans Firebase Console

1. **Dans Firebase Console** :
   - Aller dans Authentication > Sign-in method
   - Cliquer sur "Twitter"
   - Activer le toggle "Enable"

2. **Entrer les informations** :
   - **API Key** : Coller l'API Key copiée depuis Twitter Developer Portal
   - **API Secret** : Coller l'API Key Secret copiée

3. **Sauvegarder** :
   - Cliquer sur "Save" (Enregistrer)

**Note** : Assurez-vous que le Callback URI dans Twitter correspond à celui fourni par Firebase.

---

### 5.4 Apple Sign-In (Connexion Apple / iCloud)

#### Étape 1 : Prérequis Apple Developer

**IMPORTANT** : Vous devez avoir un compte Apple Developer (99$/an) pour utiliser Apple Sign-In.

1. **Aller sur Apple Developer Portal** :
   - Ouvrir [https://developer.apple.com/](https://developer.apple.com/)
   - Se connecter avec votre compte Apple Developer

2. **Créer un App ID** :
   - Aller dans "Certificates, Identifiers & Profiles"
   - Cliquer sur "Identifiers" > "+" pour créer un nouvel identifiant
   - Sélectionner "App IDs" > "Continue"
   - Sélectionner "App" > "Continue"
   - **Description** : Entrer un nom (ex: "Application1")
   - **Bundle ID** : Entrer `com.example.application1` (doit correspondre à votre app)
   - Cocher "Sign In with Apple" dans les Capabilities
   - Cliquer sur "Continue" puis "Register"

3. **Créer un Service ID** (pour Firebase) :
   - Dans "Identifiers", créer un nouvel identifiant de type "Services IDs"
   - **Description** : Entrer un nom (ex: "Application1 Firebase")
   - **Identifier** : Entrer un ID unique (ex: `com.example.application1.firebase`)
   - Cocher "Sign In with Apple"
   - Cliquer sur "Configure" à côté de "Sign In with Apple"
   - **Primary App ID** : Sélectionner l'App ID créé précédemment
   - **Website URLs** :
     - **Domains** : Ajouter `your-project.firebaseapp.com`
     - **Return URLs** : Ajouter `https://your-project.firebaseapp.com/__/auth/handler`
   - Cliquer sur "Save" puis "Continue" puis "Register"

4. **Créer une Key** :
   - Aller dans "Keys" > "+" pour créer une nouvelle clé
   - **Key Name** : Entrer un nom (ex: "Application1 Apple Sign In")
   - Cocher "Sign In with Apple"
   - Cliquer sur "Configure" et sélectionner l'App ID créé précédemment
   - Cliquer sur "Save" puis "Continue"
   - **IMPORTANT** : Télécharger la clé (.p8) - vous ne pourrez la télécharger qu'une seule fois !
   - **Key ID** : Noter cette valeur (ex: `ABC123DEF4`)

#### Étape 2 : Configurer dans Firebase Console

1. **Dans Firebase Console** :
   - Aller dans Authentication > Sign-in method
   - Cliquer sur "Apple"
   - Activer le toggle "Enable"

2. **Entrer les informations** :
   - **Services ID** : Entrer le Service ID créé (ex: `com.example.application1.firebase`)
   - **Apple Team ID** : Trouver dans Apple Developer Portal > Membership (ex: `ABCD123456`)
   - **Key ID** : Entrer le Key ID noté précédemment (ex: `ABC123DEF4`)
   - **Private Key** : Ouvrir le fichier .p8 téléchargé et copier tout son contenu (y compris les lignes `-----BEGIN PRIVATE KEY-----` et `-----END PRIVATE KEY-----`)

3. **Sauvegarder** :
   - Cliquer sur "Save" (Enregistrer)

**Note** : Apple Sign-In nécessite iOS 13+ et fonctionne uniquement sur les appareils Apple réels (pas sur le simulateur).

---

## Obtenir le SHA-1 pour Android (Google Sign-In)

Le SHA-1 est une empreinte de votre clé de signature Android. Firebase en a besoin pour authentifier votre application.

### Méthode 1 : Via Gradle (Recommandé)

#### Sur Windows (PowerShell) :

1. **Ouvrir le terminal** dans le dossier du projet
2. **Aller dans le dossier android** :
   ```powershell
   cd android
   ```
3. **Exécuter la commande** :
   ```powershell
   .\gradlew signingReport
   ```
   Ou si ça ne fonctionne pas :
   ```powershell
   gradlew.bat signingReport
   ```

#### Sur macOS/Linux :

1. **Ouvrir le terminal** dans le dossier du projet
2. **Aller dans le dossier android** :
   ```bash
   cd android
   ```
3. **Rendre le script exécutable** (si nécessaire) :
   ```bash
   chmod +x gradlew
   ```
4. **Exécuter la commande** :
   ```bash
   ./gradlew signingReport
   ```

#### Interpréter le résultat :

Après l'exécution, chercher dans la sortie :

```
Variant: debug
Config: debug
Store: C:\Users\VotreNom\.android\debug.keystore
Alias: AndroidDebugKey
MD5: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
SHA1: AA:BB:CC:DD:EE:FF:00:11:22:33:44:55:66:77:88:99:AA:BB:CC:DD
SHA-256: YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY:YY
```

**Copier la valeur SHA1** (celle qui commence par `AA:BB:CC:...`)

### Méthode 2 : Via Keytool (Alternative)

Si Gradle ne fonctionne pas, utiliser keytool :

#### Sur Windows :

```powershell
keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```

#### Sur macOS/Linux :

```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

Dans la sortie, chercher "SHA1:" et copier la valeur.

### Ajouter le SHA-1 dans Firebase Console

1. **Aller dans Firebase Console** :
   - Ouvrir votre projet Firebase
   - Cliquer sur l'icône engrenage > "Paramètres du projet"

2. **Sélectionner votre app Android** :
   - Dans "Vos applications", cliquer sur votre application Android

3. **Ajouter l'empreinte** :
   - Faire défiler jusqu'à "Empreintes de certificat SHA"
   - Cliquer sur "Ajouter une empreinte"
   - Coller le SHA-1 copié (format : `AA:BB:CC:DD:EE:FF:...`)
   - Cliquer sur "Enregistrer"

**Note** : Pour la version release, vous devrez obtenir le SHA-1 de votre keystore de production de la même manière.

---

## Vérification

### Vérifier que tout fonctionne :

1. **Vérifier les fichiers de configuration** :
   - ✅ `android/app/google-services.json` existe
   - ✅ `ios/Runner/GoogleService-Info.plist` existe (si vous testez sur iOS)

2. **Vérifier dans Firebase Console** :
   - ✅ Authentication > Sign-in method : Tous les providers sont "Enabled"
   - ✅ Paramètres du projet > Vos applications : Les apps Android et iOS sont configurées
   - ✅ SHA-1 ajouté pour Android (si vous utilisez Google Sign-In)

3. **Tester l'application** :
   - Lancer l'app avec `flutter run`
   - Essayer de s'inscrire avec email/password
   - Essayer de se connecter avec les providers OAuth configurés

### Erreurs courantes et solutions :

- **"No Firebase App '[DEFAULT]' has been created"** : Les fichiers de configuration ne sont pas au bon endroit
- **"SHA-1 not registered"** : Le SHA-1 n'a pas été ajouté dans Firebase Console
- **"Invalid API key"** : Les clés OAuth sont incorrectes dans Firebase Console
- **"Redirect URI mismatch"** : L'URI de redirection ne correspond pas entre le provider et Firebase


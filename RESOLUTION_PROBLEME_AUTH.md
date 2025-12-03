# Résolution du Problème d'Authentification Firebase

## 🔴 Problème Identifié

Les erreurs suivantes apparaissent lors de l'inscription/connexion :
- `RecaptchaCallWrapper: Initial task failed for action RecaptchaAction(action=signInWithPassword)`
- `A network error (such as timeout, interrupted connection or unreachable host) has occurred`

## ✅ Corrections Appliquées

### 1. Permissions Internet ajoutées
- ✅ Ajout de `<uses-permission android:name="android.permission.INTERNET" />`
- ✅ Ajout de `<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />`

### 2. Gestion des erreurs réseau améliorée
- ✅ Détection spécifique des erreurs réseau
- ✅ Messages d'erreur plus clairs pour l'utilisateur

## 🔧 Solutions à Vérifier

### Étape 1 : Vérifier l'Authentification dans Firebase Console

1. **Ouvrir Firebase Console** : [https://console.firebase.google.com/](https://console.firebase.google.com/)

2. **Sélectionner votre projet** : `application1-48be5`

3. **Aller dans Authentication** :
   - Menu de gauche → **Authentication**
   - Si c'est la première fois, cliquer sur **"Commencer"** (Get started)

4. **Activer Email/Password** :
   - Onglet **"Sign-in method"** (Méthodes de connexion)
   - Chercher **"Email/Password"**
   - Cliquer dessus
   - **Activer** le toggle "Enable"
   - Cliquer sur **"Save"** (Enregistrer)

### Étape 2 : Vérifier la Connectivité Internet

1. **Sur votre appareil/émulateur** :
   - Vérifiez que vous avez une connexion Internet active
   - Testez avec un navigateur web pour confirmer

2. **Sur l'émulateur Android** :
   ```bash
   # Vérifier que l'émulateur a Internet
   adb shell ping -c 3 google.com
   ```

3. **Si l'émulateur n'a pas Internet** :
   - Redémarrez l'émulateur
   - Vérifiez vos paramètres réseau
   - Sur Windows : Vérifiez que le pare-feu n'est pas bloqué

### Étape 3 : Configurer le SHA-1 (Important pour Android)

Le SHA-1 est nécessaire pour que Firebase fonctionne correctement sur Android.

#### Obtenir le SHA-1 :

**Sur Windows (PowerShell)** :
```powershell
cd android
.\gradlew signingReport
```

**Sur macOS/Linux** :
```bash
cd android
./gradlew signingReport
```

Dans la sortie, cherchez :
```
SHA1: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
```

#### Ajouter le SHA-1 dans Firebase Console :

1. **Firebase Console** → **Paramètres du projet** (icône engrenage)
2. **Vos applications** → Sélectionner votre app Android
3. **Empreintes de certificat SHA** → **Ajouter une empreinte**
4. Coller le SHA-1 copié
5. Cliquer sur **Enregistrer**

### Étape 4 : Vérifier les Fichiers de Configuration

Vérifiez que les fichiers sont présents :
- ✅ `android/app/google-services.json` doit exister
- ✅ `ios/Runner/GoogleService-Info.plist` doit exister (si iOS)

### Étape 5 : Rebuilder l'Application

Après avoir fait les modifications :

```bash
# Nettoyer le build
flutter clean

# Récupérer les dépendances
flutter pub get

# Rebuild l'application
flutter run
```

### Étape 6 : Vérifier les Logs

Dans les logs, vous devriez voir :
- ✅ `✅ Firebase initialisé avec succès`
- ✅ Pas d'erreur `RecaptchaCallWrapper`

## 🐛 Dépannage Supplémentaire

### Si le problème persiste :

1. **Vérifier que Firebase est bien initialisé** :
   - Regardez les logs au démarrage de l'app
   - Vous devriez voir "✅ Firebase initialisé avec succès"

2. **Vérifier le nom du package** :
   - Le package doit être : `com.example.application1`
   - Vérifiez dans `android/app/build.gradle.kts` : `applicationId = "com.example.application1"`

3. **Désactiver temporairement le pare-feu/antivirus** :
   - Parfois les pare-feu bloquent les connexions Firebase

4. **Essayer avec un autre réseau** :
   - WiFi différent
   - Connexion mobile
   - VPN désactivé

5. **Vérifier les règles Firestore** (si vous utilisez Firestore) :
   - Firebase Console → Firestore Database → Rules
   - Assurez-vous que les règles permettent l'accès

## 📱 Test sur Appareil Réel

Si le problème persiste sur l'émulateur, testez sur un appareil réel :
- Les problèmes réseau sont moins fréquents sur appareil réel
- Utilisez `flutter run` avec votre téléphone connecté en USB

## 📝 Codes d'Erreur Courants

- **"network-request-failed"** : Problème de connexion Internet
- **"operation-not-allowed"** : Email/Password non activé dans Firebase
- **"invalid-api-key"** : Problème avec google-services.json
- **"missing-or-invalid-nonce"** : Problème de configuration SHA-1

## 🔗 Ressources

- [Documentation Firebase Auth](https://firebase.google.com/docs/auth)
- [Guide de dépannage Firebase](https://firebase.google.com/support/troubleshooting)
- [Configuration SHA-1](https://developers.google.com/android/guides/client-auth)

## ✨ Résumé des Actions

1. ✅ Permissions Internet ajoutées
2. ✅ Gestion d'erreurs améliorée
3. ⚠️ **À FAIRE** : Activer Email/Password dans Firebase Console
4. ⚠️ **À FAIRE** : Ajouter le SHA-1 dans Firebase Console
5. ⚠️ **À FAIRE** : Rebuilder l'application (`flutter clean && flutter pub get && flutter run`)


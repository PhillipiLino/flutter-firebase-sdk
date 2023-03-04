# Firebase SDK Mobile

![Github Badge](https://img.shields.io/badge/Version-1.0.0-<>)
![Github Badge](https://img.shields.io/badge/-Flutter-3dbbe3?&logo=Flutter)
![Github Badge](https://img.shields.io/badge/-Dart-268bab?&logo=Dart)
![Github Badge](https://img.shields.io/badge/-NullSafety-268bab)

Pacote de integração do Firebase.

# Sumário

- [Firebase SDK Mobile](#firebase-sdk-mobile)
- [Sumário](#sumário)
  - [Informações técnicas](#informações-técnicas)
    - [Versão atual](#versão-atual)
    - [Dependências](#dependências)
  - [Instalação](#instalação)
  - [Implementação](#implementação)
  - [Componentes](#componentes)
  - [**CrashlyticsErrorReport**](#crashlyticserrorreport)
    - [**RecordException**](#recordexception)
  - [**FirebaseAnalyticsAdapter**](#firebaseanalyticsadapter)
    - [**logEvent**](#logevent)
    - [**setDefaultParameters**](#setdefaultparameters)
    - [**setUserProperty**](#setuserproperty)
  - [**FirebaseCrashlyticsAdapter**](#firebasecrashlyticsadapter)
    - [**logEvent**](#logevent-1)
  - [**FirebaseDatabaseAdapter**](#firebasedatabaseadapter)
    - [**getCollection**](#getcollection)
    - [**addFieldToCollection**](#addfieldtocollection)
    - [**saveUserLogin**](#saveuserlogin)
  - [**FirebaseMessagingAdapter**](#firebasemessagingadapter)
    - [**subscribeToTopics**](#subscribetotopics)
    - [**unsubscribeFromTopics**](#unsubscribefromtopics)
    - [**requestPermission**](#requestpermission)
    - [**getMessagingToken**](#getmessagingtoken)
  - [**FirebaseSDK**](#firebasesdk)
    - [**initialize**](#initialize)
    - [**recordCrashlyticsError**](#recordcrashlyticserror)
    - [**logSuccessLogin**](#logsuccesslogin)
    - [**setLogedUser**](#setlogeduser)
    - [**removeUserData**](#removeuserdata)
    - [**trackButtonClick**](#trackbuttonclick)
    - [**trackCustomEvent**](#trackcustomevent)
    - [**trackPageOpen**](#trackpageopen)
    - [**stopTrackPage**](#stoptrackpage)
    - [**sendData**](#senddata)
    - [**subscribeToTopics**](#subscribetotopics-1)
    - [**unsubscribeFromTopics**](#unsubscribefromtopics-1)
    - [**requestPermission**](#requestpermission-1)
    - [**getMessagingToken**](#getmessagingtoken-1)
    - [FIM](#fim)

## Informações técnicas
---

### Versão atual

* 1.0.0 (Acesse o [changelog](CHANGELOG.md) para visualizar todas mudanças)

### Dependências

- `firebase_core`: ^1.20.0
- `firebase_analytics`: ^9.2.1
- `firebase_crashlytics`: ^2.8.6
- `cloud_firestore`: ^3.4.0
- `firebase_sdk`:
- `flutter_lints`: ^2.0.0
- `mocktail`: ^0.3.0

<br/>

## Instalação
---

Adicionar a seguinte dependência (com base em como você vai utilizar) no seu arquivo `pubspec.yaml` e logo após rodar o comando `flutter pub get` para baixar a dependência

- Versão do Github:
```yaml
firebase_sdk:
    git:
        url: https://github.com/PhillipiLino/flutter-firebase-sdk
        ref: {nome_da_branch}
```

- Versão local:
```yaml
firebase_sdk:
    path: {caminho_do_pacote}
```

<br/>

## Implementação
---

<br/>

Para utilizar os seviços do Firebase em seu projeto, é necessário inicializar o Firebase da seguinte forma:

```dart
await FirebaseSDK.initialize(
    name: `nome_do_projeto`,
    options: `arquivo_de_configuracao`,
);
```

Exemplo:

```dart
await FirebaseSDK.initialize(
    name: 'app_name',
    options: DefaultFirebaseOptions.currentPlatform,
);
```

Para usar o crashlytics e mapear os erros, faça da seguinte maneira no `main` do seu projeto:

```dart
void main() async {
    runZonedGuarded<Future<void>>(() async {
        WidgetsFlutterBinding.ensureInitialized();
        await FirebaseSDK.initialize(
            name: 'app_name',
            options: DefaultFirebaseOptions.currentPlatform,
        );

        FlutterError.onError = FirebaseSDK.recordCrashlyticsFlutterFatalError;

        final app = ModularApp(
            module: AppModule(),
            child: const AppWidget(),
        );

        runApp(app);

        Modular.setInitialRoute(splashRoute);
    },
    (error, stack) {
      FirebaseSDK.recordCrashlyticsError(error, stack, true);
    },
  );
}
```

## Componentes
---

<br/>

## **CrashlyticsErrorReport**
------

```dart
CrashlyticsErrorReport();
```
</br>

### **RecordException**

```dart
Future recordException({
    required Exception exception,
    required StackTrace stack,
    required String reason,
    int? errorCode,
    bool printDebugLog = true,
})
```

- `exception`: Erro a ser mandado para o Crashlytics;
- `stack`: Stacktrace do erro;
- `reason`: Texto com alguma mensagem do erro;
- `errorCode`: Código do erro;
- `printDebugLog`: parâmetro que diz se deve mostrar no console o log desse erro;


<br/>

## **FirebaseAnalyticsAdapter**
------

```dart
FirebaseAnalyticsAdapter(FirebaseAnalytics analytics);
```
</br>

### **logEvent**

```dart
Future logEvent({
    required String eventName,
    required Map<String, dynamic> eventInfos,
})
```
</br>

### **setDefaultParameters**

```dart
Future setDefaultParameters(Map<String, Object> params)
```
</br>

### **setUserProperty**

```dart
Future setUserProperty({required String name, required String? value})
```</br>

### **setUserId**

```dart
Future setUserId(String? userId)
```</br>

### **logLogin**

```dart
Future logLogin()
```</br>

### **setCurrentPage**

```dart
Future setCurrentPage(String pageName)
```

<br/>

## **FirebaseCrashlyticsAdapter**
------

```dart
FirebaseCrashlyticsAdapter(FirebaseCrashlytics analytics);
```
</br>

### **logEvent**

```dart
Future recordError({
    required Exception exception,
    required StackTrace stack,
    required String reason,
    int? errorCode,
    bool printDebugLog = true,
})
```

<br/>

## **FirebaseDatabaseAdapter**
------

```dart
FirebaseDatabaseAdapter(FirebaseFirestore analytics);
```
</br>

### **getCollection**

```dart
Future<CollectionReference> getCollection(String collectionName)
```
</br>

### **addFieldToCollection**

```dart
Future addFieldToCollection(
    CollectionReference collectionRef,
    Map<String, Object> info, [
    String? path,
])
```
</br>

### **saveUserLogin**

```dart
Future saveUserLogin(
    String userId,
    String email, {
    Map<String, dynamic>? aditionalInfos,
})
```

<br/>

## **FirebaseMessagingAdapter**
------

```dart
FirebaseMessagingAdapter(FirebaseMessaging messaging);
```
</br>

### **subscribeToTopics**
```dart
subscribeToTopics(List<String> topics)
```

</br>

### **unsubscribeFromTopics**
```dart
unsubscribeFromTopics(List<String> topics)
```

</br>

### **requestPermission**
```dart
Future<bool> requestPermission()
```

</br>

### **getMessagingToken**
```dart
Future<String> getMessagingToken()
```


<br/>

## **FirebaseSDK**
------

```dart
FirebaseSDK();
```
</br>

### **initialize**

```dart
static initialize({String? name, FirebaseOptions? options})
```
</br>

### **recordCrashlyticsError**

```dart
static recordCrashlyticsError(Object error, StackTrace stackTrace, isFatal)
```
</br>

### **logSuccessLogin**

```dart
Future logSuccessLogin(
    String userId,
    String email, {
    Map<String, dynamic>? aditionalInfos,
})
```
</br>

### **setLogedUser**

```dart
Future setLogedUser({
    required String userId,
    required String email,
    required String name,
    Map<String, dynamic>? aditionalInfos,
})
```
</br>

### **removeUserData**

```dart
Future removeUserData()
```
</br>

### **trackButtonClick**

```dart
Future trackButtonClick(
    String btnName, {
    required Map<String, dynamic> infos,
})
```
</br>

### **trackCustomEvent**

```dart
Future trackCustomEvent(
    String eventName, {
    required Map<String, dynamic> infos,
})
```
</br>

### **trackPageOpen**

```dart
Future trackPageOpen(String pageName)
```
</br>

### **stopTrackPage**

```dart
Future stopTrackPage(
    String pageName, {
    required Map<String, dynamic>? infos,
})
```
</br>

### **sendData**

```dart
Future sendData({
    required String collectionName,
    required Map<String, Object> info,
    String? path,
})
```

</br>

### **subscribeToTopics**
```dart
subscribeToTopics(List<String> topics)
```

</br>

### **unsubscribeFromTopics**
```dart
unsubscribeFromTopics(List<String> topics)
```

</br>

### **requestPermission**
```dart
Future<bool> requestPermission()
```

</br>

### **getMessagingToken**
```dart
Future<String> getMessagingToken()
```

### FIM
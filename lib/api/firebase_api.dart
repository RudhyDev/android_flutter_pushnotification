import 'package:android_flutter_pushnotification/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  // criar uma instancia do Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  //funcão para inicializar as notificações
  Future<void> initNotifications() async {
    //pedir permissão para o usuário
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    //se o usuário permitir, então fazer o fetc do FCM (Firebase Cloud Messaging) token para esse dispositivo
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? fCMToken = await _firebaseMessaging.getToken();

      // printar o token (Apenas para o teste), mas normalmente esse token seria enviado para o backend
      // ignore: avoid_print
      print("FirebaseMessaging token: $fCMToken");

      // inicializar os settings iniciais
      initPushNotifications();
    }
  }

  //função para lidar com as notificaçoes recebidas
  void handleMessage(RemoteMessage? message) {
    // se a mensagem for null não fazer nada
    if (message == null) return;

    // se a mensagem tiver dados, então fazer o push para a tela de notificação
    navigatorKey.currentState!.pushNamed('/notification_screen', arguments: message);
  }

  //função para lidar com as notificações quando o app estiver em segundo plano
  Future initPushNotifications() async {
    // tratativa para quando o app foi fechado e agora está aberto
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // event listener para quando a notificação abrir o app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}

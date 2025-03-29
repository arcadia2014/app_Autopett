
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:integradora_appmovil3/preferences/pref_usuario.dart';


part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {

  FirebaseMessaging messaging = FirebaseMessaging.instance;


  NotificationsBloc() : super(NotificationsInitial()) {
    _onForegroundMessage();
  }

  void requestPermition () async {

    NotificationSettings settings = await messaging.requestPermission(

      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert:  true,
      provisional: false,
      sound: true
    );

    settings.authorizationStatus;
    _getToken();

  }

  void _getToken() async{

    final settings = await messaging.getNotificationSettings();
    if(settings.authorizationStatus != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    if(token != null){
      final prefs = PrefUsuario();
      prefs.token = token;
    }
  }
 
  void _onForegroundMessage(){
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

   void handleRemoteMessage (RemoteMessage message){
    var mensaje = message.data;
    var body = mensaje ['body'];
    var title = mensaje ['title'];
  }
}

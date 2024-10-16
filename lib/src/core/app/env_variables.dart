import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvTybe { dev, prod }

class EnvVariable {
  EnvVariable._();
  static final EnvVariable instance = EnvVariable._();
  String _envType = '';
  String _notificationBaseUrl = '';
  String _firebaseKey = '';
  Future<void> init({required EnvTybe envTybe}) async {
    switch (envTybe) {
      case EnvTybe.dev:
        await dotenv.load(fileName: '.env.dev');
      case EnvTybe.prod:
        await dotenv.load(fileName: '.env.prod');
    }
    _envType = dotenv.get('ENV_TYPE');
    _notificationBaseUrl = dotenv.get('NOTFICATION_BASEURL');
    _firebaseKey = dotenv.get('FIREBASE_KEY');
  }

  String get envType => _envType;
  bool get debugMode => _envType == 'dev';
  String get notificationBaseUrl => _notificationBaseUrl;
  String get firebaseKey => _firebaseKey;
}

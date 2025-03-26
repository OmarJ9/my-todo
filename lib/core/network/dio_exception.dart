import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "La demande au serveur API a été annulée";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Délai de connexion avec le serveur API";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Recevoir le délai d'attente en relation avec le serveur API";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = "Envoyer un délai d'attente en relation avec le serveur API";
        break;
      case DioExceptionType.connectionError:
        if (dioError.message?.contains("SocketException") ?? false) {
          message = "Pas d'Internet";
          break;
        } else if (dioError.message?.contains('HandshakeException') ?? false) {
          message = 'Données de réponse introuvables';
          break;
        }
        message = "Une erreur inattendue s'est produite";
        break;
      default:
        message = "Quelque chose s'est mal passé";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    final isString = error['message'] is String;
    switch (statusCode) {
      case 400:
        return isString
            ? error['message']
            : error['message'].first ?? 'Mauvaise demande';
      case 401:
        return isString
            ? error['message']
            : error['message'].first ?? 'Non autorisé';
      case 403:
        return isString
            ? error['message']
            : error['message'].first ?? 'Interdite';
      case 404:
        return isString
            ? error['message']
            : error['message'].first ?? 'Pas trouvé';
      case 420:
        return 'La session a expiré.Veuillez vous connecter à nouveau';
      case 500:
        return error['message'] ?? 'Erreur interne du serveur';
      case 502:
        return error['message'] ?? 'Serveur indisponible';
      case 503:
        return error['message'] ?? 'Serveur indisponible';
      default:
        return "Oups quelque chose s'est mal passé";
    }
  }

  @override
  String toString() => message;
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/phrase.dart';

class ApiService {
  // TODO: Remplacer par l'URL de production après déploiement
  static const String baseUrl = 'http://localhost:3000/api';

  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  Future<Phrase> getRandomPhrase() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/phrase/random'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Phrase.fromJson(data);
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } catch (e) {
      // En cas d'erreur, retourner une phrase par défaut
      return Phrase.defaultPhrase();
    }
  }
}

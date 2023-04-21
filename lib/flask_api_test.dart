import 'package:http/http.dart' as http;
import 'dart:convert';

class Prediction {
  final String disease;
  final String predictionImageUrl;

  Prediction({required this.disease, required this.predictionImageUrl});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      disease: json['prediction'],
      predictionImageUrl: json['prediction_image_url'],
    );
  }
}

Future<Prediction> getPrediction(String imagePath) async {
  final uri = Uri.parse('https://5a41-41-89-64-52.ngrok-free.app');
  var request = http.MultipartRequest('POST', uri)
    ..files.add(await http.MultipartFile.fromPath('file', imagePath));
  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    return Prediction.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to get prediction');
  }
}

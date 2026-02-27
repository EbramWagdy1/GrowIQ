import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  final String cloudName = 'ddpwxk6re';
  final String uploadPreset = 'GrowIQ';

  Future<String?> uploadImage(File image) async {
    final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    final request = http.MultipartRequest('POST', uri);
    request.fields['upload_preset'] = uploadPreset;
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final resString = await response.stream.bytesToString();
      final data = jsonDecode(resString);
      return data['secure_url'];
    } else {
      // ignore: avoid_print
      print('Cloudinary Upload Failed: ${response.statusCode}');
      return null;
    }
  }
}
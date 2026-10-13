import 'dart:convert';
import 'package:http/http.dart' as http;
class StudentService {
  Future<dynamic>getApi(String url)async{
    final response = await http.get(Uri.parse(url));
    return handleResponse(response);
  }
  Future<dynamic>postApi(String url,[Map<String , dynamic>?body])async{
    final response = await http.post(Uri.parse(url),
    headers: {
      'Content-Type':'application/json',
      'Accept':'application/json'
    },body: jsonEncode(body ?? {}),
    );
    return handleResponse(response);
  }
  Future<dynamic>putApi(String url, Map<String ,dynamic>body)async{
    final response = await http.put(Uri.parse(url),
    headers: {
    'Content-Type':'application/json',
    'Accept':'application/json'
    },body: jsonEncode(body));
    return handleResponse(response);
  }
  Future<dynamic>deleteApi(String url )async{
    final response = await http.delete(Uri.parse(url));
    return handleResponse(response);
  }
  dynamic handleResponse(http.Response response){
    if (response.statusCode >=200 && response.statusCode<300){
      if (response.body.isEmpty) return null ;
      return jsonDecode(response.body);
    }
    throw Exception('Api Error${response.statusCode},${response.body}');
  }
}

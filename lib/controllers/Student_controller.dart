import '../service/student_service.dart';

class StudentController {
  final StudentService service = StudentService();

  Future<dynamic> getApi(String url) {
    return service.getApi(url);
  }

  Future<dynamic> postApi(String url, [Map<String, dynamic>? body]) {
    return service.postApi(url, body);
  }

  Future<dynamic> putApi(String url, Map<String, dynamic> body) {
    return service.putApi(url, body);
  }

  Future<dynamic> deleteApi(String url) {
    return service.deleteApi(url);
  }
}

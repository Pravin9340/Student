
class Endpoints {
  static const baseUrl = 'http://127.0.0.1:8000';
  static const students = '$baseUrl/students/';
  static String detail(String endpoint, int id) {
    return '$endpoint$id/';
  }
}

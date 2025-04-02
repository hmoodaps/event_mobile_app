import 'dart:math';

String generateReferenceNumber() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  final randomString = List.generate(8, (index) => chars[random.nextInt(chars.length)]).join();
  return 'NL-$randomString';
}

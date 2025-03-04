// import 'dart:convert';

// import 'package:http/http.dart';

// var baseUrl = 'http://116.68.206.157:9445/api';

// var requestHeader = {"Content-Type": "application/json"};

// Future<bool> loginRequest(formValues) async {
//   var url = Uri.parse("$baseUrl/login");
//   var postBody = json.encode(formValues);
//   var response = await post(url, headers: requestHeader, body: postBody);
//   var resultCode = response.statusCode;
//   var resultBody = json.decode(response.body);
//   if (resultCode == 200 && resultBody['status'] == "success") {
//     print('true');
//     return true;
//   } else {
//     print('false');
//     return false;
//   }
// }

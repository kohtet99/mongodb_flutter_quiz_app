import 'dart:convert';
import 'package:http/http.dart' as http;

// API endpoint URL
var apiLink = 'http://192.168.1.38:8080/api/quiz'; //Use wifi or network IPv4 address for localhost

// Function to fetch quiz data
Future<List<dynamic>> getQuizData() async {
  var res = await http.get(Uri.parse(apiLink));

  // Check if the request was successful
  if (res.statusCode == 200) {
    // Decode the response body
    var data = jsonDecode(res.body);

    // Ensure the data is in the expected format (List<dynamic>)
    if (data is List) {
      return data.cast<dynamic>(); // Explicitly cast to List<dynamic>
    } else {
      throw Exception('Unexpected data format');
    }
  } else {
    throw Exception('Failed to load quiz data');
  }
}


// errorcode

// import 'dart:convert';

// import 'package:http/http.dart' as http;

// // var apiLink = 'https://opentdb.com/api.php?amount=10&category=23';
// // var apiLink = 'localhost:8080/api/quiz';

// var apiLink = 'http://192.168.55.86:8080/api/quiz';

// getQuizData() async {
//   var res = await http.get(Uri.parse(apiLink));
//   if (res.statusCode == 200) {
//     var data = jsonDecode(res.body.toString());
//     return data;
//   }
// }

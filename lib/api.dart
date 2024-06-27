import 'dart:convert';
import 'package:pamiw/post.dart';
import 'package:shelf_router/shelf_router.dart';
// ignore: depend_on_referenced_packages
import 'package:shelf/shelf.dart';
// ignore: depend_on_referenced_packages
import 'package:shelf/shelf_io.dart' as io;
//import 'package:http/http.dart' as http;

void main() async {
  final app = Router();

  // Your existing code for the /posts endpoint
  app.post('/posts', (Request request) async {
    try {
      // Read the request body
      //final requestBody = await request.readAsString();
      // Parse the JSON data
      //final jsonData = jsonDecode(requestBody);

      // Create a Post object from the JSON data
      //final post = Post.fromJson(jsonData);

      // Return a response indicating success
      return Response.ok('Post added successfully');
    } catch (e) {
      // Return a response indicating failure if there is an error
      return Response.internalServerError(body: 'Error adding post: $e');
    }
  });

  // Adding predefined posts from jsonDataList
  List<Map<String, dynamic>> jsonDataList = [
    {
      'userId': '1',
      'title': 'First Post',
      'body': 'This is the description for the first post.',
    },
    {
      'userId': '2',
      'title': 'Second Post',
      'body': 'Description for the second post goes here.',
    },
    {
      'userId': '3',
      'title': 'Third Post',
      'body': 'Description for the third post.',
    },
  ];

  // Create a list to store Post objects
  List<Post> posts = [];

  // Convert each JSON data to a Post object and add it to the list
  for (var jsonData in jsonDataList) {
    Post post = Post.fromJson(jsonData);
    posts.add(post);
  }

    app.get('/', (Request request) {
    return Response.ok("Dziala");
  });

  // Expose the predefined posts list at the /posts endpoint
  app.get('/posts', (Request request) {
    final List<Map<String, dynamic>> postsJsonList =
        posts.map((post) => post.toJson()).toList();
    return Response.ok(jsonEncode(postsJsonList));
  });

  app.get('/get/<userId>', (Request request, String userId) {
    // Find the post with the specified userId
    final post =
        posts.firstWhere((post) => post.userId == userId);

    final Map<String, dynamic> postJson = post.toJson();
    return Response.ok(jsonEncode(postJson),
        headers: {'content-type': 'application/json'});
    });
  

  // Start the server on port 5000
  final server = await io.serve(app.call, 'localhost', 5555);
  // ignore: avoid_print
  print('Server is running on http://${server.address.host}:${server.port}');
}

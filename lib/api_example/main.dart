// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:test_project/api_example/example_api.dart';

// void main() {
//   final dio = Dio();

//   dio.interceptors.add(LogInterceptor());

//   final exampleApi = ExampleApi(dio);
//   runApp(MultipartExample(api: exampleApi));
// }

// class MultipartExample extends StatefulWidget {
//   const MultipartExample({super.key, required this.api});

//   final ExampleApi api;

//   @override
//   State<MultipartExample> createState() => _MultipartExampleState();
// }

// class _MultipartExampleState extends State<MultipartExample> {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextField(
//                 controller: nameController,
//               ),
//               TextField(
//                 controller: emailController,
//               ),
//               OutlinedButton(
//                 onPressed: () async {
//                   final path = (await getApplicationDocumentsDirectory()).path;

//                   // final file = File('$path/text.txt').writeAsString('lol');

//                   widget.api.testMultipartRequest(
//                     nameController.text,
//                     emailController.text,
//                     File('$path/text.txt'),
//                   );
//                 },
//                 child: const Text('Press me'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ApiExampleWidget extends StatefulWidget {
//   final ExampleApi api;
//   const ApiExampleWidget({required this.api, super.key});

//   @override
//   State<ApiExampleWidget> createState() => _ApiExampleWidgetState();
// }

// class _ApiExampleWidgetState extends State<ApiExampleWidget> {
//   bool requested = false;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(32),
//           child: Center(
//             child: requested
//                 ? GestureDetector(
//                     onTap: () => setState(() => requested = false),
//                     child: FutureBuilder(
//                       future: widget.api.getCat(),
//                       builder: (context, snapshot) {
//                         final data = snapshot.data?.firstOrNull;

//                         if (data == null) {
//                           return const CircularProgressIndicator();
//                         }

//                         return ClipRRect(
//                           borderRadius: BorderRadius.circular(16),
//                           child: Image.network(data.url),
//                         );
//                       },
//                     ),
//                   )
//                 : OutlinedButton(
//                     onPressed: () => setState(() => requested = true),
//                     child: const Text('Press me'),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';

// import 'package:dio/dio.dart' hide Headers;
// import 'package:flutter/foundation.dart';
// import 'package:retrofit/retrofit.dart';
// import 'package:test_project/api_example/cat.dart';

// part 'example_api.g.dart';

// @RestApi(
//   baseUrl: 'https://api.thecatapi.com/v1',
//   // parser: Parser.FlutterCompute,
// )
// abstract class ExampleApi {
//   factory ExampleApi(Dio dio, {String baseUrl}) = _ExampleApi;

//   @GET('/images/search')
//   Future<List<Cat>> getCat();

//   @POST('/multipart')
//   @MultiPart()
//   Future<String> testMultipartRequest(
//     @Part(name: 'name') String name,
//     @Part(name: 'email') String email,
//     @Part(name: 'file') File file,
//   );

//   @POST('/form')
//   @FormUrlEncoded()
//   Future<void> testFormUrlEncoded(
//     @Field('name') String name,
//     String email,
//   );

//   @GET('/header-test')
//   @Headers({
//     'Cache-Control': 'max-age=8192',
//   })
//   Future<String> testHeader();
// }

// Cat deserializeCat(Map<String, dynamic> json) => Cat.fromJson(json);
// List<Cat> deserializeCatList(List<Map<String, dynamic>> json) =>
//     json.map((e) => Cat.fromJson(e)).toList();

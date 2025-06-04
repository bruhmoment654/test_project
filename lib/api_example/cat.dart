import 'package:json_annotation/json_annotation.dart';

part 'cat.g.dart';

@JsonSerializable()
class Cat {
  final String id;
  final String url;
  final int width;
  final int height;

  const Cat({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);

  Map<String, dynamic> toJson() => _$CatToJson(this);
}

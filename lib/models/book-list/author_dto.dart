import 'package:json_annotation/json_annotation.dart';

part 'author_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthorDto {
  @JsonKey(name: "birth_year", nullable: true)
  final int birthYear;
  @JsonKey(name: "death_year", nullable: true)
  final int deathYear;
  final String name;

  AuthorDto({this.birthYear, this.deathYear, this.name});

  factory AuthorDto.fromJson(Map<String, dynamic> json) =>
      _$AuthorDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorDtoToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorDto _$AuthorDtoFromJson(Map<String, dynamic> json) {
  return AuthorDto(
    birthYear: json['birth_year'] as int,
    deathYear: json['death_year'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$AuthorDtoToJson(AuthorDto instance) => <String, dynamic>{
      'birth_year': instance.birthYear,
      'death_year': instance.deathYear,
      'name': instance.name,
    };

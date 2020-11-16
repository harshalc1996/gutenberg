// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenreList _$GenreListFromJson(Map<String, dynamic> json) {
  return GenreList(
    genreIcon: json['genreIcon'] as String,
    genreTitle: json['genreTitle'] as String,
  );
}

Map<String, dynamic> _$GenreListToJson(GenreList instance) => <String, dynamic>{
      'genreIcon': instance.genreIcon,
      'genreTitle': instance.genreTitle,
    };

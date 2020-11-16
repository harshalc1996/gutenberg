// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksListDto _$BooksListDtoFromJson(Map<String, dynamic> json) {
  return BooksListDto(
    count: json['count'] as int,
    next: json['next'] as String,
    previous: json['previous'] as String,
    results: (json['results'] as List)
        ?.map((e) => e == null
            ? null
            : BookDetailDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BooksListDtoToJson(BooksListDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results?.map((e) => e?.toJson())?.toList(),
    };

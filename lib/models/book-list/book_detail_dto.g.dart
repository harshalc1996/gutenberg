// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookDetailDto _$BookDetailDtoFromJson(Map<String, dynamic> json) {
  return BookDetailDto(
    id: json['id'] as int,
    title: json['title'] as String,
    subjects: (json['subjects'] as List)?.map((e) => e as String)?.toList(),
    authors: (json['authors'] as List)
        ?.map((e) =>
            e == null ? null : AuthorDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    bookshelves:
        (json['bookshelves'] as List)?.map((e) => e as String)?.toList(),
    languages: (json['languages'] as List)?.map((e) => e as String)?.toList(),
    copyright: json['copyright'] as bool,
    mediaType: json['media_type'] as String,
    formats: (json['formats'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    downloadCount: json['download_count'] as int,
  );
}

Map<String, dynamic> _$BookDetailDtoToJson(BookDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subjects': instance.subjects,
      'authors': instance.authors?.map((e) => e?.toJson())?.toList(),
      'bookshelves': instance.bookshelves,
      'languages': instance.languages,
      'copyright': instance.copyright,
      'media_type': instance.mediaType,
      'formats': instance.formats,
      'download_count': instance.downloadCount,
    };

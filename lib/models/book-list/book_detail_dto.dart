import 'package:json_annotation/json_annotation.dart';
import './author_dto.dart';

part 'book_detail_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class BookDetailDto {
  final int id;
  final String title;
  final List<String> subjects;
  final List<AuthorDto> authors;
  final List<String> bookshelves;
  final List<String> languages;
  @JsonKey(nullable: true)
  final bool copyright;
  @JsonKey(name: "media_type")
  final String mediaType;
  final Map<String, String> formats;
  @JsonKey(name: "download_count")
  final int downloadCount;

  BookDetailDto({
    this.id,
    this.title,
    this.subjects,
    this.authors,
    this.bookshelves,
    this.languages,
    this.copyright,
    this.mediaType,
    this.formats,
    this.downloadCount,
  });

  factory BookDetailDto.fromJson(Map<String, dynamic> json) =>
      _$BookDetailDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BookDetailDtoToJson(this);
}

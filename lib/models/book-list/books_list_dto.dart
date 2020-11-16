import 'package:json_annotation/json_annotation.dart';

import './book_detail_dto.dart';

part 'books_list_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class BooksListDto {
  final int count;
  @JsonKey(nullable: true)
  final String next;
  @JsonKey(nullable: true)
  final String previous;
  final List<BookDetailDto> results;

  BooksListDto({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory BooksListDto.fromJson(Map<String, dynamic> json) =>
      _$BooksListDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BooksListDtoToJson(this);
}

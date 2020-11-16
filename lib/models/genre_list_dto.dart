import 'package:json_annotation/json_annotation.dart';
part 'genre_list_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class GenreList {
  final String genreIcon;
  final String genreTitle;

  GenreList({this.genreIcon, this.genreTitle});

  factory GenreList.fromJson(Map<String, dynamic> json) =>
      _$GenreListFromJson(json);
  Map<String, dynamic> toJson() => _$GenreListToJson(this);
}

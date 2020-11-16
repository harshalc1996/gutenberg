import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../common/api_error_exception.dart';
import '../common/assets.dart';
import '../common/size_config.dart';
import '../models/book-list/books_list_dto.dart';
import '../models/genre_list_dto.dart';
import '../pages/book_list.dart';
import '../providers/booklist_provider.dart';

class BuildBookList extends StatelessWidget {
  BooklistProvider _booklistProvider;

  Future<BooksListDto> getBooksByGenre(String genreTitle) async {
    var apiResponse = await http.get(
        'http://skunkworks.ignitesol.com:8000/books?mime_type=image&topic=' +
            genreTitle);

    if (apiResponse.statusCode == 200) {
      var results = json.decode(apiResponse.body);

      BooksListDto bookListResult = BooksListDto.fromJson(results);
      _booklistProvider = BooklistProvider.init(bookListResult, genreTitle);

      return bookListResult;
    } else if (apiResponse.statusCode == 204) {
      throw APIErrorException('No data found');
    } else {
      throw APIErrorException('Oops Some Error Occurred!!');
    }
  }

  @override
  Widget build(BuildContext context) {
    GenreList genre = ModalRoute.of(context).settings.arguments;
    return FutureBuilder(
      future: getBooksByGenre(genre.genreTitle),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildLoadingWidget(context, genre);
        } else if (snapshot.hasError) {
          return buildErrorWidget(context, genre, snapshot.error);
        } else {
          return buildDataWidget(
            context,
            genre,
            snapshot.data,
          );
        }
      },
    );
  }

  Widget buildLoadingWidget(BuildContext context, GenreList genre) {
    final themeData = Theme.of(context);
    return Hero(
      tag: genre.genreTitle,
      child: Scaffold(
        backgroundColor: themeData.accentColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: themeData.accentColor,
          centerTitle: false,
          title: Text(
            genre.genreTitle,
            style: themeData.textTheme.headline4.copyWith(
              color: themeData.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Center(
          child: Container(
            child: CircularProgressIndicator(
              value: null,
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildErrorWidget(
      BuildContext context, GenreList genre, APIErrorException error) {
    final themeData = Theme.of(context);
    return Hero(
      tag: genre.genreTitle,
      child: Scaffold(
        backgroundColor: themeData.accentColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: themeData.accentColor,
          centerTitle: false,
          title: Text(
            genre.genreTitle,
            style: themeData.textTheme.headline4.copyWith(
              color: themeData.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Center(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: themeData.errorColor,
                style: BorderStyle.solid,
                width: 1,
              ),
              color: Colors.grey[200],
            ),
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(10.0),
            child: Text(
              error.toString(),
              style: themeData.textTheme.headline4.copyWith(
                color: themeData.errorColor,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDataWidget(
      BuildContext context, GenreList genre, BooksListDto booksData) {
    // TextEditingController searchCtrl = new TextEditingController(
    //   text: '',
    // );
    final themeData = Theme.of(context);
    return ChangeNotifierProvider<BooklistProvider>.value(
      // create: (BuildContext context) => _booklistProvider,
      value: _booklistProvider,
      child: Hero(
        tag: genre.genreTitle,
        child: Scaffold(
          backgroundColor: themeData.accentColor,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: themeData.accentColor,
            centerTitle: false,
            title: Text(
              genre.genreTitle,
              style: themeData.textTheme.headline4.copyWith(
                color: themeData.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            bottom: PreferredSize(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: _booklistProvider.searchCtrl,
                  style: themeData.textTheme.bodyText1.copyWith(
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat_Regular',
                    fontSize: 18 * SizeConfig.safeAreaTextScalingFactor,
                  ),
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    alignLabelWithHint: true,
                    hintText: 'Search',
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(4.0),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: SvgPicture.asset(
                        Assets.SEARCH,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minHeight: 20,
                      minWidth: 20,
                      maxHeight: 34,
                      maxWidth: 34,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _booklistProvider.clearSearch();
                      },
                      icon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset(
                          Assets.CANCEL,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  onChanged: (String val) {
                    _booklistProvider.onSearchFunction(val);
                  },
                ),
              ),
              preferredSize: Size.fromHeight(kToolbarHeight - 10),
            ),
          ),
          body: BookList(),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../common/assets.dart';
import '../common/api_error_exception.dart';
import '../models/book-list/book_detail_dto.dart';
import '../models/book-list/books_list_dto.dart';

class BooklistProvider with ChangeNotifier {
  BooksListDto _booksListResult;
  String _genreTopic;
  List<BookDetailDto> _booksList;
  int _currentPage = 1;
  String _searchedString;
  TextEditingController searchCtrl = new TextEditingController(text: '');
  bool pageLoader = false;
  bool bookOpenError = false;

  /* Function on Initialization of provider
    @params (BooksListDto booklist_result),
    @params (String genre_title),
  */
  BooklistProvider.init(BooksListDto list, String genre) {
    this._booksListResult = list;
    this._booksList = list.results;
    this._genreTopic = genre;
  }

  /* get list of book object */
  List<BookDetailDto> get getBooksList {
    return this._booksList;
  }

  /* Getter for genre title */
  String get genreTitle {
    return this._genreTopic;
  }

  /* Function to clear search and reinitialize api to get books list */
  void clearSearch() {
    if (this._searchedString != null || this._searchedString != '') {
      this._searchedString = null;
      this.searchCtrl.text = '';
      this.searchCtrl.clear();
      this._currentPage = 0;
      this._booksList = [];
      notifyListeners();
      getMoreBooks();
    }
  }

  /* API to get list of books based on page along with other params */
  Future<void> getMoreBooks() async {
    if (this._booksListResult.next != null || this._currentPage < 1) {
      this.pageLoader = true;
      notifyListeners();
      this._currentPage = this._currentPage + 1;
    } else {
      return;
    }
    var apiResponse = await http.get(
        'http://skunkworks.ignitesol.com:8000/books?mime_type=image&topic=' +
            this._genreTopic +
            '&page=' +
            this._currentPage.toString() +
            (this._searchedString != null
                ? '&search=' + Uri.encodeComponent(this._searchedString)
                : ''));

    if (apiResponse.statusCode == 200) {
      var results = json.decode(apiResponse.body);

      BooksListDto res = BooksListDto.fromJson(results);
      this._booksListResult = res;
      this._booksList.addAll(res.results);
      this.pageLoader = false;
      notifyListeners();
    } else if (apiResponse.statusCode == 204) {
      this.pageLoader = false;
      notifyListeners();
      throw APIErrorException('No data found');
    } else {
      this.pageLoader = false;
      notifyListeners();
      throw APIErrorException('Oops Some Error Occurred!!');
    }
  }

  /*
    API to get list of books based on search
    @params (String searched_keyword)  
  */
  Future<void> onSearchFunction(String key) async {
    this._currentPage = 1;
    this.pageLoader = true;
    notifyListeners();
    this._searchedString = key;
    var apiResponse = await http.get(
        'http://skunkworks.ignitesol.com:8000/books?mime_type=image&topic=' +
            this._genreTopic +
            '&search=' +
            Uri.encodeComponent(key));

    if (apiResponse.statusCode == 200) {
      var results = json.decode(apiResponse.body);

      BooksListDto res = BooksListDto.fromJson(results);
      this._booksListResult = res;
      this._booksList = res.results;
      this.pageLoader = false;
      notifyListeners();
    } else if (apiResponse.statusCode == 204) {
      this.pageLoader = false;
      notifyListeners();
      throw APIErrorException('No data found');
    } else {
      this.pageLoader = false;
      notifyListeners();
      throw APIErrorException('Oops Some Error Occurred!!');
    }
  }

  /*
    API to get single book detail
    @params (int book_id)  
  */
  Future<bool> getBookDetails(int id) async {
    var apiResponse = await http
        .get('http://skunkworks.ignitesol.com:8000/books/' + id.toString());

    if (apiResponse.statusCode == 200) {
      BookDetailDto bookDetail =
          BookDetailDto.fromJson(json.decode(apiResponse.body));

      String url = '';

      if (bookDetail.formats.containsKey('text/html; charset=utf-8')) {
        url = bookDetail.formats['text/html; charset=utf-8'];
        if (await canLaunch(url)) {
          await launch(url);
          return true;
        } else {
          return false;
        }
      } else if (bookDetail.formats.containsKey('application/pdf')) {
        url = bookDetail.formats['application/pdf'];
        if (await canLaunch(url)) {
          await launch(url);
          return true;
        } else {
          return false;
        }
      } else if (bookDetail.formats.containsKey('text/plain')) {
        var keysArr = bookDetail.formats.keys;
        var k = keysArr.firstWhere((element) => element.contains('text/plain'));
        url = bookDetail.formats[k];
        if (url.endsWith('zip')) {
          return false;
        } else {
          if (await canLaunch(url)) {
            await launch(url);
            return true;
          } else {
            return false;
          }
        }
      } else {
        return false;
      }
    } else if (apiResponse.statusCode == 204) {
      return false;
    } else {
      return false;
    }
  }

  /* Get Assets based on Genre Title */
  String getAssetByGenre() {
    var genre = genreTitle.toLowerCase();
    if (genre == 'fiction') {
      return Assets.FICTION;
    } else if (genre == 'drama') {
      return Assets.DRAMA;
    } else if (genre == 'humour') {
      return Assets.HUMOUR;
    } else if (genre == 'politics') {
      return Assets.POLITICS;
    } else if (genre == 'philosophy') {
      return Assets.PHILOSOPHY;
    } else if (genre == 'history') {
      return Assets.HISTORY;
    } else if (genre == 'adventure') {
      return Assets.ADVENTURE;
    } else {
      return Assets.CANCEL;
    }
  }
}

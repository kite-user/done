import 'package:done/src/repository/app_repository.dart';
import 'package:flutter/widgets.dart';

class SearchController extends ChangeNotifier {
  final AppRepository repository;

  SearchController(this.repository);
}

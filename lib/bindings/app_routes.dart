part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const DETAIL = _Paths.DETAIL;
  static const VIDEO = _Paths.VIDEO;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const DETAIL = '/detail';
  static const VIDEO = '/video';
}


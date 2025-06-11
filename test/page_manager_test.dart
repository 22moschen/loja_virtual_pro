import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:loja_virtual_pro/models/page_manager.dart';

class FakePageController extends Fake implements PageController {
  int? jumpedToPage;

  @override
  void jumpToPage(int page) {
    jumpedToPage = page;
  }
}

void main() {
  group('PageManager Tests', () {
    test('setPage updates page and calls jumpToPage if different', () {
      final fakeController = FakePageController();
      final pageManager = PageManager(fakeController);

      pageManager.setPage(1);

      expect(pageManager.page, 1);
      expect(fakeController.jumpedToPage, 1);
    });

    test('setPage does nothing if page is the same', () {
      final fakeController = FakePageController();
      final pageManager = PageManager(fakeController);

      pageManager.setPage(0);

      expect(pageManager.page, 0);
      expect(fakeController.jumpedToPage, isNull);
    });
  });
}

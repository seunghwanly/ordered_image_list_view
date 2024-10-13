import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ordered_image_list_view/ordered_image_list_view.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    '`OrderedImageListView` should call next image when current image is loaded',
    (tester) async {
      final List<Uri> urls = [
        Uri.parse('https://picsum.photos/id/1/300/300'),
        Uri.parse('https://picsum.photos/id/2/300/300'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OrderedImageListView.network(urls: urls),
          ),
        ),
      );
      await tester.pumpAndSettle();

      /// HttpClient will cause 400 Bad Request
      expect(find.byType(CallbackImage), findsExactly(1));
    },
  );
}

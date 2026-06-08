import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myproject/main.dart';

void main() {
  testWidgets('renders daily habit dashboard and opens create menu', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('2 ngày liên tiếp'), findsOneWidget);
    expect(find.text('Học Tiếng Anh'), findsWidgets);
    expect(find.text('Ngày hôm nay'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('Tạo 1 thói quen mới'), findsOneWidget);
    expect(find.text('Nhật kí hằng ngày'), findsOneWidget);
  });
}

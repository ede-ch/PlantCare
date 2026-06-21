import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:plantcare_app/main.dart';

void main() {
  testWidgets('App renders PlantCare text', (WidgetTester tester) async {
    await tester.pumpWidget(const PlantCareApp());

    expect(find.text('PlantCare'), findsOneWidget);
  });
}

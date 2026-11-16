import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/app/core/constants/app_strings.dart';

void main() {
  testWidgets('Portfolio loads and displays developer name on desktop', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text(AppStrings.developerName), findsWidgets);
  });

  testWidgets('Portfolio loads and displays developer name on mobile', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text(AppStrings.developerName), findsWidgets);
  });
}

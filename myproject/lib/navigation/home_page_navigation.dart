import 'package:flutter/material.dart';
import '../pages/insight_general_page.dart';
import '../pages/insight_page.dart';
import '../pages/reflection_page.dart';

class HomePageNavigation {
  static void navigateToInsightGeneral(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InsightGeneralPage()),
    );
  }

  static void navigateToInsight(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InsightPage()),
    );
  }

  static void navigateToReflection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ReflectionPage()),
    );
  }
}

import 'package:flutter/cupertino.dart';

class DefineJobCategory {
  final List<dynamic> homeServiceSkills;
  final List<dynamic> deliverySkills;
  final List<dynamic> leisureSkills;
  final List<dynamic> miscSkills;
  final List<dynamic> personalHealthSkills;

  DefineJobCategory({
    @required this.homeServiceSkills,
    @required this.deliverySkills,
    @required this.leisureSkills,
    @required this.miscSkills,
    @required this.personalHealthSkills,
  });

  String getCategory() {
    if (homeServiceSkills.length >= deliverySkills.length &&
        homeServiceSkills.length >= leisureSkills.length &&
        homeServiceSkills.length >= miscSkills.length &&
        homeServiceSkills.length >= personalHealthSkills.length) {
      return 'Home';
    }
    if (deliverySkills.length >= homeServiceSkills.length &&
        deliverySkills.length >= leisureSkills.length &&
        deliverySkills.length >= miscSkills.length &&
        deliverySkills.length >= personalHealthSkills.length) {
      return 'Auto';
    }
    if (leisureSkills.length >= deliverySkills.length &&
        leisureSkills.length >= homeServiceSkills.length &&
        leisureSkills.length >= miscSkills.length &&
        leisureSkills.length >= personalHealthSkills.length) {
      return 'Leisure';
    }
    if (miscSkills.length >= deliverySkills.length &&
        miscSkills.length >= leisureSkills.length &&
        miscSkills.length >= homeServiceSkills.length &&
        miscSkills.length >= personalHealthSkills.length) {
      return 'Other';
    }
    if (personalHealthSkills.length >= deliverySkills.length &&
        personalHealthSkills.length >= leisureSkills.length &&
        personalHealthSkills.length >= miscSkills.length &&
        personalHealthSkills.length >= homeServiceSkills.length) {
      return 'Self Care';
    }

    return '';
  }
}

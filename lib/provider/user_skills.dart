import 'package:flutter/cupertino.dart';

class UserSkills with ChangeNotifier {
  List<dynamic> _deliveryAndAutomotiveSkills = [];

  List<dynamic> get deliveryAndAutomotiveSkills {
    return [..._deliveryAndAutomotiveSkills];
  }

  void addDeliveryAndAutomotiveSkills(List<dynamic> skills) {
    _deliveryAndAutomotiveSkills = skills;
    notifyListeners();
  }

  List<dynamic> _homeServiceSkills = [];

  List<dynamic> get homeServiceSkills {
    return [..._homeServiceSkills];
  }

  void addHomeServiceSkills(List<dynamic> skills) {
    _homeServiceSkills = skills;
    notifyListeners();
  }

  List<dynamic> _personalHealthCareSkills = [];

  List<dynamic> get personalHealthCareSkills {
    return [..._personalHealthCareSkills];
  }

  void addPersonalHealthCareSkills(List<dynamic> skills) {
    _personalHealthCareSkills = skills;
    notifyListeners();
  }

  List<dynamic> _leisureServiceSkills = [];

  List<dynamic> get leisureServiceSkills {
    return [..._leisureServiceSkills];
  }

  void addLeisureServiceSkills(List<dynamic> skills) {
    _leisureServiceSkills = skills;
    notifyListeners();
  }

  List<dynamic> _miscellaneousSkills = [];

  List<dynamic> get miscellaneousSkills {
    return [..._miscellaneousSkills];
  }

  void addMiscellaneousSkills(List<dynamic> skills) {
    _miscellaneousSkills = skills;
    notifyListeners();
  }
}

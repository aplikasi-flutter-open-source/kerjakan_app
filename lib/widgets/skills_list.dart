import 'package:flutter/material.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/provider/user_data.dart';
import 'package:kerjakanapp/provider/user_skills.dart';
import 'package:provider/provider.dart';

class SkillsList extends StatefulWidget {
  @override
  _SkillsListState createState() => _SkillsListState();
}

class _SkillsListState extends State<SkillsList> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final Map<String, dynamic> _userData =
          Provider.of<UserData>(context, listen: false).userData;

      if (_userData['delivery_skills'] != null) {
        Provider.of<UserSkills>(context, listen: false)
            .addDeliveryAndAutomotiveSkills(_userData['delivery_skills']);
      }
      if (_userData['home_service_skills'] != null) {
        Provider.of<UserSkills>(context, listen: false)
            .addHomeServiceSkills(_userData['home_service_skills']);
      }
      if (_userData['personal_health_skills'] != null) {
        Provider.of<UserSkills>(context, listen: false)
            .addPersonalHealthCareSkills(_userData['personal_health_skills']);
      }
      if (_userData['leisure_skills'] != null) {
        Provider.of<UserSkills>(context, listen: false)
            .addLeisureServiceSkills(_userData['leisure_skills']);
      }
      if (_userData['misc_skills'] != null) {
        Provider.of<UserSkills>(context, listen: false)
            .addMiscellaneousSkills(_userData['misc_skills']);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> _allSkills = [];
    final List<dynamic> _deliveryAndAutomotiveSkills =
        Provider.of<UserSkills>(context).deliveryAndAutomotiveSkills;
    final List<dynamic> _homeServiceSkills =
        Provider.of<UserSkills>(context).homeServiceSkills;
    final List<dynamic> _personalHealthCareSkills =
        Provider.of<UserSkills>(context).personalHealthCareSkills;
    final List<dynamic> _leisureServiceSkills =
        Provider.of<UserSkills>(context).leisureServiceSkills;
    final List<dynamic> _miscellaneousSkills =
        Provider.of<UserSkills>(context).miscellaneousSkills;

    _deliveryAndAutomotiveSkills.forEach((element) {
      _allSkills.add(element);
    });
    _homeServiceSkills.forEach((element) {
      _allSkills.add(element);
    });
    _personalHealthCareSkills.forEach((element) {
      _allSkills.add(element);
    });
    _leisureServiceSkills.forEach((element) {
      _allSkills.add(element);
    });
    _miscellaneousSkills.forEach((element) {
      _allSkills.add(element);
    });

    return _allSkills.length == 0
        ? Container()
        : GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(4.0),
            itemCount: _allSkills.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 6 / 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                height: 36,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (_deliveryAndAutomotiveSkills
                            .contains(_allSkills[index])) {
                          _deliveryAndAutomotiveSkills.removeWhere(
                              (element) => element == _allSkills[index]);
                          Provider.of<UserSkills>(context, listen: false)
                              .addDeliveryAndAutomotiveSkills(
                                  _deliveryAndAutomotiveSkills);
                        } else if (_homeServiceSkills
                            .contains(_allSkills[index])) {
                          _homeServiceSkills.removeWhere(
                              (element) => element == _allSkills[index]);
                          Provider.of<UserSkills>(context, listen: false)
                              .addHomeServiceSkills(_homeServiceSkills);
                        } else if (_personalHealthCareSkills
                            .contains(_allSkills[index])) {
                          _personalHealthCareSkills.removeWhere(
                              (element) => element == _allSkills[index]);
                          Provider.of<UserSkills>(context, listen: false)
                              .addPersonalHealthCareSkills(
                                  _personalHealthCareSkills);
                        } else if (_leisureServiceSkills
                            .contains(_allSkills[index])) {
                          _leisureServiceSkills.removeWhere(
                              (element) => element == _allSkills[index]);
                          Provider.of<UserSkills>(context, listen: false)
                              .addLeisureServiceSkills(_leisureServiceSkills);
                        } else if (_miscellaneousSkills
                            .contains(_allSkills[index])) {
                          _miscellaneousSkills.removeWhere(
                              (element) => element == _allSkills[index]);
                          Provider.of<UserSkills>(context, listen: false)
                              .addMiscellaneousSkills(_miscellaneousSkills);
                        }

                        print('delete');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.close,
                          size: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _allSkills[index],
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          color: primaryColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}

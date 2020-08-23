import 'package:flutter/material.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/provider/user_data.dart';
import 'package:kerjakanapp/screens/employer_list_screen.dart';
import 'package:kerjakanapp/screens/home_screen_employer.dart';
import 'package:kerjakanapp/screens/home_screen_job_seeker.dart';
import 'package:kerjakanapp/screens/job_seeker_list_screen.dart';
import 'package:kerjakanapp/screens/profile_employer_screen.dart';
import 'package:kerjakanapp/screens/profile_job_sekeer_screen.dart';
import 'package:kerjakanapp/widgets/drawer_menu.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  static const String routeName = '/drawer-screen';
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen>
    with SingleTickerProviderStateMixin {
  bool _isCollapsed = true;
  String _menu = 'home';
  String _userStatus;
  bool _isWorking = true;
  double screenHeight, screenWidth;
  AnimationController _controller;
  Animation<Offset> _slideAnimation;

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _userStatus = Provider.of<UserData>(context, listen: false).userMode;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeCollapsedStatus() {
    setState(() {
      _isCollapsed ? _controller.forward() : _controller.reverse();
      _isCollapsed = !_isCollapsed;
    });
  }

  void _changeWorkingStatus() {
    setState(() {
      _isWorking = !_isWorking;
    });
  }

  void _changeActiveMenu(String activeMenu) {
    setState(() {
      _menu = activeMenu;
    });
  }

  void _changeUserStatus(String status) {
    setState(() {
      _userStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      backgroundColor: primaryDarkColor,
      body: Stack(
        children: [
          SlideTransition(
            position: _slideAnimation,
            child: DrawerMenu(
              changeUserStatus: _changeUserStatus,
              userStatus: _userStatus,
              changeMenu: _changeActiveMenu,
              activeMenu: _menu,
              changeCollapse: _changeCollapsedStatus,
              isWorking: _isWorking,
              changeWorkingStatus: _changeWorkingStatus,
            ),
          ),
          Positioned(
            top: 0.3 * screenHeight,
            bottom: 0.3 * screenWidth,
            left: 0.6 * screenWidth,
            right: -0.4 * screenWidth,
            child: ClipRRect(
              borderRadius: _isCollapsed
                  ? BorderRadius.circular(0)
                  : BorderRadius.circular(16),
              child: Material(
                elevation: 8,
                color: Color(0xFF5973BD),
                child: Scaffold(
                  backgroundColor: Color(0xFF5973BD),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: _isCollapsed ? 0 : 0.2 * screenHeight,
            bottom: _isCollapsed ? 0 : 0.2 * screenWidth,
            left: _isCollapsed ? 0 : 0.7 * screenWidth,
            right: _isCollapsed ? 0 : -0.3 * screenWidth,
            child: GestureDetector(
              onTap: () {
                if (!_isCollapsed) {
                  print('masuk');
                  setState(() {
                    _isCollapsed = true;
                  });
                }
              },
              child: ClipRRect(
                borderRadius: _isCollapsed
                    ? BorderRadius.circular(0)
                    : BorderRadius.circular(16),
                child: _userStatus == 'Mencari Pekerjaan'
                    ? Material(
                        elevation: 8,
                        color: primaryColor,
                        child: _menu == 'home'
                            ? HomeScreenJobSeeker(
                                changeCollapseStatus: _changeCollapsedStatus)
                            : _menu == 'job'
                                ? JobSeekerList(
                                    changeCollapseStatus:
                                        _changeCollapsedStatus)
                                : ProfileJobSeekerScreen(
                                    changeCollapseStatus:
                                        _changeCollapsedStatus),
                      )
                    : Material(
                        elevation: 8,
                        color: primaryColor,
                        child: _menu == 'home'
                            ? HomeScreenEmployer(
                                changeCollapseStatus: _changeCollapsedStatus)
                            : _menu == 'job'
                                ? EmployerList(
                                    changeCollapseStatus:
                                        _changeCollapsedStatus)
                                : ProfileEmployerScreen(
                                    changeCollapseStatus:
                                        _changeCollapsedStatus),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

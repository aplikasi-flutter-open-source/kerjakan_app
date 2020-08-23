import 'package:flutter/material.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/main.dart';
import 'package:kerjakanapp/provider/nearby_jobseeker.dart';
import 'package:kerjakanapp/provider/user_data.dart';
import 'package:kerjakanapp/screens/home_screen_job_seeker.dart';
import 'package:kerjakanapp/screens/job_seeker_detail_screen.dart';
import 'package:kerjakanapp/screens/sign_up_screen_2.dart';
import 'package:provider/provider.dart';

import 'drawer_screen.dart';

class GiveRatingScreen extends StatefulWidget {
  static const String routeName = '/give-rating-screen';

  @override
  _GiveRatingScreenState createState() => _GiveRatingScreenState();
}

class _GiveRatingScreenState extends State<GiveRatingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _rating = 3;
  String comment;

  JobSeeker jobSeeker;

  var _isInit = true;

  Future<void> giveReview() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();

    try {
      final _userData = Provider.of<UserData>(context, listen: false).userData;
      await Provider.of<NearbyJobSeeker>(context, listen: false).sendCommend(
          jobSeeker.id.toString(),
          comment,
          _userData['name'],
          _userData['photo_url'],
          _rating.toString());

      Navigator.of(context).pushNamedAndRemoveUntil(
          MainScreen.routeName, (Route<dynamic> route) => false,
          arguments: jobSeeker);
    } catch (error) {
      throw error;
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      jobSeeker = ModalRoute.of(context).settings.arguments;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4C6DE3),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 14.0,
                        color: greyColor,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Review Anda',
                            style: TextStyle(
                                fontFamily: 'Kayak',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Bagaimana pengalaman Anda?',
                            style: TextStyle(
                                fontFamily: 'Kayak',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 64,
                      ),
                      Image.asset(
                        _rating <= 3
                            ? 'assets/images/rate_1.png'
                            : _rating <= 4
                                ? 'assets/images/rate_2.png'
                                : 'assets/images/rate_3.png',
                        width: 88,
                        height: 88,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        _rating <= 3
                            ? 'Baik'
                            : _rating <= 4 ? 'Sangat Baik' : 'Memuaskan!',
                        style: TextStyle(
                            fontFamily: 'Kayak',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 64,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(
                              _rating >= 1 ? Icons.star : Icons.star_border,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _rating = 1;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              _rating >= 2 ? Icons.star : Icons.star_border,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _rating = 2;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              _rating >= 3 ? Icons.star : Icons.star_border,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _rating = 3;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              _rating >= 4 ? Icons.star : Icons.star_border,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _rating = 4;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              _rating >= 5 ? Icons.star : Icons.star_border,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _rating = 5;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Theme(
                        data: ThemeData(
                          primaryColor: Colors.white,
                          primaryColorDark: Colors.white,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Kayak",
                              color: Colors.white),
//                      focusNode: _passFocusNode,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 0.0),
                            ),
                            hintText: 'Beri Komentar',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: "Kayak",
                                color: Colors.white),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 16.0,
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Mohon beri komentar';
                            }
                          },
                          onSaved: (value) {
                            comment = value;
                          },
//                      onFieldSubmitted: (value) => _submit(),
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                    ],
                  ),
                  Container(
                    width: 148,
                    height: 40,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: FlatButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      onPressed: giveReview,
                      child: Text(
                        'Krim',
                        style: TextStyle(color: primaryDarkColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/provider/recommend_job.dart';
import 'package:kerjakanapp/provider/user_data.dart';
import 'package:kerjakanapp/screens/nearby_job_screen.dart';
import 'package:kerjakanapp/screens/recommend_job_screen.dart';
import 'package:kerjakanapp/widgets/item_job.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatelessWidget {
  final List<Job> _listNearbyJob;
  final List<Job> _listRecommendJob;
  final ScrollController _scrollController;

  HomeContent(
      this._listNearbyJob, this._scrollController, this._listRecommendJob);

  @override
  Widget build(BuildContext context) {
    final _userData = Provider.of<UserData>(context, listen: false).userData;
    if (_userData['delivery_skills'] == null) {
      _userData['delivery_skills'] = [];
    }
    if (_userData['personal_health_skills'] == null) {
      _userData['personal_health_skills'] = [];
    }
    if (_userData['misc_skills'] == null) {
      _userData['misc_skills'] = [];
    }
    if (_userData['leisure_skills'] == null) {
      _userData['leisure_skills'] = [];
    }
    if (_userData['home_service_skills'] == null) {
      _userData['home_service_skills'] = [];
    }
    final List<String> _userSkills = [
      ..._userData['delivery_skills'],
      ..._userData['home_service_skills'],
      ..._userData['leisure_skills'],
      ..._userData['misc_skills'],
      ..._userData['personal_health_skills']
    ];
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2.2,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                color: Colors.white,
              ),
              height: 40,
              child: Center(
                child: Container(
                  width: 24,
                  height: 3,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const Text(
              'Pekerjaan Terdekat',
              style: titleStyle,
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Daftar pekerjaan-pekerjaan yang berada di sekitar Anda.',
              style: descStyle,
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed(NearbyJobScreen.routeName),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: primaryLighterColor),
                child: ListTile(
                  leading: Container(
                    alignment: Alignment.center,
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: Text(
                      (_listNearbyJob.length).toString(),
                      style: TextStyle(
                          fontFamily: 'Kayak',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: accentColor),
                    ),
                  ),
                  title: Text(
                    'Daftar Pekerjaan Terdekat',
                    style: TextStyle(
                        fontFamily: 'Kayak',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white),
                  ),
                  subtitle: Text(
                    'Lihat semua pekerjaan yang tersedia di sekitar Anda',
                    style: TextStyle(
                        fontFamily: 'Kayak', fontSize: 10, color: Colors.white),
                  ),
                  trailing: RotatedBox(
                    quarterTurns: 90,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            if (_listNearbyJob.length > 0) ItemJob(_listNearbyJob[0]),
            if (_listNearbyJob.length > 1) ItemJob(_listNearbyJob[1]),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Rekomendasi Pekerjaan',
              style: titleStyle,
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Yang bisa Anda kerjakan sesuai dengan keahlian pilihan Anda!',
              style: descStyle,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _userSkills.length > 3 ? 4 : _userSkills.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: primaryLighterColor.withOpacity(0.1)),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  height: 40,
                  child: index < 3
                      ? Text(
                          _userSkills[index],
                          style: TextStyle(
                            fontFamily: 'Kayak',
                            fontSize: 12,
                            color: primaryLighterColor,
                          ),
                        )
                      : Text(
                          '+ ${_userSkills.length - 3} Lainnya',
                          style: TextStyle(
                            fontFamily: 'Kayak',
                            fontSize: 12,
                            color: primaryLighterColor,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed(RecommendJobScreen.routeName),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: primaryLighterColor),
                child: ListTile(
                  leading: Container(
                    alignment: Alignment.center,
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: Text(
                      (_listRecommendJob.length).toString(),
                      style: TextStyle(
                        fontFamily: 'Kayak',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: accentColor,
                      ),
                    ),
                  ),
                  title: Text(
                    'Daftar Rekomendasi Pekerjaan',
                    style: TextStyle(
                        fontFamily: 'Kayak',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white),
                  ),
                  subtitle: Text(
                    'Lihat semua rekomendasi pekerjaan untuk Anda',
                    style: TextStyle(
                        fontFamily: 'Kayak', fontSize: 10, color: Colors.white),
                  ),
                  trailing: RotatedBox(
                    quarterTurns: 90,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  ItemJob(_listRecommendJob[index]),
              itemCount: _listRecommendJob.length,
            ),
          ],
        ),
      ),
    );
  }
}

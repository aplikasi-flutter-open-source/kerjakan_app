import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/provider/nearby_jobseeker.dart';
import 'package:kerjakanapp/provider/recommend_job.dart';
import 'package:kerjakanapp/screens/nearby_job_screen.dart';
import 'package:kerjakanapp/screens/nearby_job_seeker_screen.dart';
import 'package:kerjakanapp/screens/open_job_screen.dart';
import 'package:kerjakanapp/screens/recommend_job_screen.dart';
import 'package:kerjakanapp/widgets/item_job.dart';
import 'package:kerjakanapp/widgets/item_jobseeker.dart';
import 'package:provider/provider.dart';

class HomeContentEmployer extends StatelessWidget {
  final ScrollController _scrollController;

  HomeContentEmployer(this._scrollController);

  @override
  Widget build(BuildContext context) {
    final _listNearbyJobSeeker =
        Provider.of<NearbyJobSeeker>(context, listen: false).items;
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
              'Request Pekerjaan',
              style: titleStyle,
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Permintaan pekerjaan atau jasa yang Ada inginkan.',
              style: descStyle,
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed(OpenJobScreen.routeName),
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
                    child: Image.asset(
                      'assets/images/ic_open_job.png',
                      width: 14.55,
                      height: 16,
                    ),
                  ),
                  title: Text(
                    'Buat Lowongan',
                    style: TextStyle(
                        fontFamily: 'Kayak',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white),
                  ),
                  subtitle: Text(
                    'Buat lowongan dan lihat pekerja terbaik menawarkan jasanya!',
                    style: TextStyle(
                      fontFamily: 'Kayak',
                      fontSize: 10,
                      color: Colors.white,
                    ),
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
              height: 16,
            ),
            const Text(
              'Jasa Terdekat',
              style: titleStyle,
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Daftar jasa dan pekerja yang berada di sekitar Anda.',
              style: descStyle,
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () => Navigator.of(context)
                  .pushNamed(NearbyJobSeekerScreen.routeName),
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
                      (_listNearbyJobSeeker.length).toString(),
                      style: TextStyle(
                        fontFamily: 'Kayak',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: accentColor,
                      ),
                    ),
                  ),
                  title: Text(
                    'Daftar Jasa dan Pekerja Terdekat',
                    style: TextStyle(
                      fontFamily: 'Kayak',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    'Lihat semua jasa dan pekerja yang berada di sekitar Anda',
                    style: TextStyle(
                      fontFamily: 'Kayak',
                      fontSize: 10,
                      color: Colors.white,
                    ),
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
                  ItemJobSeeker(_listNearbyJobSeeker[index]),
              itemCount: _listNearbyJobSeeker.length,
            ),
          ],
        ),
      ),
    );
  }
}

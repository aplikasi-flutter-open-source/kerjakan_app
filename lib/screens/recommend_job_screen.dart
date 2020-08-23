import 'package:flutter/material.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/provider/recommend_job.dart';
import 'package:kerjakanapp/provider/user_data.dart';
import 'package:kerjakanapp/screens/edit_skills_screen.dart';
import 'package:kerjakanapp/widgets/item_job.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class RecommendJobScreen extends StatelessWidget {
  static const String routeName = '/recommend-job-screen';

  @override
  Widget build(BuildContext context) {
    final _listRecommendJob =
        Provider.of<RecommendJobs>(context, listen: false).items;
    final _userData = Provider.of<UserData>(context, listen: false).userData;
    final List<String> _userSkills = [
      ..._userData['delivery_skills'],
      ..._userData['home_service_skills'],
      ..._userData['leisure_skills'],
      ..._userData['misc_skills'],
      ..._userData['personal_health_skills']
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 14.0,
                        color: greyColor,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 42.0),
                        child: Text(
                          "Rekomendasi Pekerjaan",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kayak',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Keahlian Anda',
                      style: titleStyle,
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context)
                          .pushNamed(EditSkillScreen.routeName),
                      child: const Text(
                        'Perbarui',
                        style: TextStyle(
                            fontFamily: 'Kayak',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: primaryColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Rekomendasi ditampilkan berdasarkan keahlian Anda',
                  style: descStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(4.0),
                  itemCount: _userSkills.length,
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
                          color: primaryLighterColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        _userSkills[index],
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          color: primaryLighterColor,
                          fontSize: 10,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
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
        ),
      ),
    );
  }
}

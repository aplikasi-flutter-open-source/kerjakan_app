import 'package:flutter/material.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/widgets/item_job.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class NearbyJobScreen extends StatelessWidget {
  static const String routeName = '/nearby-job-screen';
  @override
  Widget build(BuildContext context) {
    final _listNearbyJob =
        Provider.of<NearbyJobs>(context, listen: false).items;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                          "Pekerjaan Terdekat",
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
                  height: 8,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      ItemJob(_listNearbyJob[index]),
                  itemCount: _listNearbyJob.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

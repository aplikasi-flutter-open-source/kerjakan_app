import 'package:flutter/material.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/screens/job_detail_screen.dart';

import '../const.dart';

class ItemJob extends StatelessWidget {
  final Job job;

  ItemJob(this.job);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        elevation: 5,
        shadowColor: greyColor.withOpacity(0.15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: () => Navigator.of(context)
              .pushNamed(JobDetailScreen.routeName, arguments: job),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: job.jobCategory == 'Home'
                          ? Image.asset(
                              'assets/images/placeholder_home.png',
                              height: 80,
                              width: 80,
                            )
                          : job.jobCategory == 'Self Care'
                              ? Image.asset(
                                  'assets/images/placeholder_self_care.png',
                                  height: 80,
                                  width: 80,
                                )
                              : job.jobCategory == 'Auto'
                                  ? Image.asset(
                                      'assets/images/placeholder_auto.png',
                                      height: 80,
                                      width: 80,
                                    )
                                  : job.jobCategory == 'Other'
                                      ? Image.asset(
                                          'assets/images/placeholder_other.png',
                                          height: 80,
                                          width: 80,
                                        )
                                      : job.jobCategory == 'Leisure'
                                          ? Image.asset(
                                              'assets/images/placeholder_leisure.png',
                                              height: 80,
                                              width: 80,
                                            )
                                          : null,
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          'assets/images/ic_banner.png',
                          width: 20,
                          height: 16,
                          color: primaryColor,
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: job.jobCategory == 'Home'
                                ? Image.asset(
                                    'assets/images/ic_house.png',
                                    width: 8,
                                    height: 8,
                                  )
                                : job.jobCategory == 'Auto'
                                    ? Image.asset(
                                        'assets/images/ic_auto.png',
                                        width: 8,
                                        height: 8,
                                      )
                                    : job.jobCategory == 'Leisure'
                                        ? Image.asset(
                                            'assets/images/ic_leisure.png',
                                            width: 8,
                                            height: 8,
                                          )
                                        : job.jobCategory == 'Other'
                                            ? Image.asset(
                                                'assets/images/ic_other.png',
                                                width: 8,
                                                height: 8,
                                              )
                                            : job.jobCategory == 'Self Care'
                                                ? Image.asset(
                                                    'assets/images/ic_personal.png',
                                                    width: 8,
                                                    height: 12,
                                                  )
                                                : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.jobTitle,
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        job.jobDesc,
                        maxLines: 2,
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Rp. ${oCcy.format(job.jobSalary)},-/ ${job.timeSalary}',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        job.jobSkills
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', ''),
                        maxLines: 2,
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

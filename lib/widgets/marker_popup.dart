import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/screens/job_detail_screen.dart';

import '../const.dart';

class MarkerPopup extends StatefulWidget {
  final Marker marker;
  final Job nearbyJob;

  MarkerPopup(this.marker, this.nearbyJob, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MarkerPopupState(this.marker);
}

class _MarkerPopupState extends State<MarkerPopup> {
  final Marker _marker;
  _MarkerPopupState(this._marker);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(JobDetailScreen.routeName, arguments: widget.nearbyJob),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widget.nearbyJob.jobCategory == 'Home'
                  ? Image.asset(
                      'assets/images/placeholder_home.png',
                      height: 80,
                      width: 80,
                    )
                  : widget.nearbyJob.jobCategory == 'Self Care'
                      ? Image.asset(
                          'assets/images/placeholder_self_care.png',
                          height: 80,
                          width: 80,
                        )
                      : widget.nearbyJob.jobCategory == 'Auto'
                          ? Image.asset(
                              'assets/images/placeholder_auto.png',
                              height: 80,
                              width: 80,
                            )
                          : widget.nearbyJob.jobCategory == 'Other'
                              ? Image.asset(
                                  'assets/images/placeholder_other.png',
                                  height: 80,
                                  width: 80,
                                )
                              : widget.nearbyJob.jobCategory == 'Leisure'
                                  ? Image.asset(
                                      'assets/images/placeholder_leisure.png',
                                      height: 80,
                                      width: 80,
                                    )
                                  : null,
              const SizedBox(
                width: 8,
              ),
              _cardDescription(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardDescription(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 100, maxWidth: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            widget.nearbyJob.jobTitle,
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
            widget.nearbyJob.jobDesc,
            maxLines: 2,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Kayak',
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Rp. ${oCcy.format(widget.nearbyJob.jobSalary)},-/ ${widget.nearbyJob.timeSalary}',
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
            widget.nearbyJob.jobSkills
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', ''),
            maxLines: 2,
            style: TextStyle(
                fontSize: 10, fontFamily: 'Kayak', color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

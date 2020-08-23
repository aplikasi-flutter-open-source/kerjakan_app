import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/provider/nearby_jobseeker.dart';
import 'package:kerjakanapp/screens/job_seeker_detail_screen.dart';
import 'package:kerjakanapp/widgets/rating_star.dart';

import '../const.dart';

class MarkerPopupEmployer extends StatefulWidget {
  final Marker marker;
  final JobSeeker nearbyJobSeeker;

  MarkerPopupEmployer(this.marker, this.nearbyJobSeeker, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MarkerPopupEmployerState(this.marker);
}

class _MarkerPopupEmployerState extends State<MarkerPopupEmployer> {
  final Marker _marker;
  _MarkerPopupEmployerState(this._marker);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
            JobSeekerDetailScreen.routeName,
            arguments: widget.nearbyJobSeeker),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Stack(
                        overflow: Overflow.visible,
                        children: [
                          Container(
                            child: widget.nearbyJobSeeker.photoUrl == 'a'
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: primaryLighterColor,
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    height: 32,
                                    width: 32,
                                    child: Image.asset(
                                      'assets/images/avatar_a.png',
                                    ),
                                  )
                                : widget.nearbyJobSeeker.photoUrl == 'b'
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: primaryLighterColor,
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        height: 32,
                                        width: 32,
                                        child: Image.asset(
                                          'assets/images/avatar_b.png',
                                        ),
                                      )
                                    : widget.nearbyJobSeeker.photoUrl == 'c'
                                        ? Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: primaryLighterColor,
                                            ),
                                            padding: const EdgeInsets.all(4),
                                            height: 32,
                                            width: 32,
                                            child: Image.asset(
                                              'assets/images/avatar_c.png',
                                            ),
                                          )
                                        : widget.nearbyJobSeeker.photoUrl == 'd'
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: primaryLighterColor,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(4),
                                                height: 32,
                                                width: 32,
                                                child: Image.asset(
                                                  'assets/images/avatar_c.png',
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  height: 32,
                                                  width: 32,
                                                  child: Image.network(
                                                    widget.nearbyJobSeeker
                                                        .photoUrl,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: -10,
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/ic_banner.png',
                                  width: 20,
                                  height: 16,
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: widget.nearbyJobSeeker.jobCategory ==
                                            'Home'
                                        ? Image.asset(
                                            'assets/images/ic_house.png',
                                            width: 8,
                                            height: 8,
                                          )
                                        : widget.nearbyJobSeeker.jobCategory ==
                                                'Auto'
                                            ? Image.asset(
                                                'assets/images/ic_auto.png',
                                                width: 8,
                                                height: 8,
                                              )
                                            : widget.nearbyJobSeeker
                                                        .jobCategory ==
                                                    'Leisure'
                                                ? Image.asset(
                                                    'assets/images/ic_leisure.png',
                                                    width: 8,
                                                    height: 8,
                                                  )
                                                : widget.nearbyJobSeeker
                                                            .jobCategory ==
                                                        'Other'
                                                    ? Image.asset(
                                                        'assets/images/ic_other.png',
                                                        width: 8,
                                                        height: 8,
                                                      )
                                                    : widget.nearbyJobSeeker
                                                                .jobCategory ==
                                                            'Self Care'
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
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      _cardDescription(context),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 36,
                    width: 190,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.nearbyJobSeeker.skills.length > 3
                          ? 4
                          : widget.nearbyJobSeeker.skills.length,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: primaryLighterColor.withOpacity(0.1)),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        height: 36,
                        child: index < 3
                            ? Text(
                                widget.nearbyJobSeeker.skills[index],
                                style: TextStyle(
                                    fontFamily: 'Kayak',
                                    fontSize: 10,
                                    color: primaryLighterColor),
                              )
                            : Text(
                                '+ ${widget.nearbyJobSeeker.skills.length - 3} More',
                                style: TextStyle(
                                    fontFamily: 'Kayak',
                                    fontSize: 10,
                                    color: primaryLighterColor),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              RotatedBox(
                quarterTurns: 90,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 14,
                ),
              ),
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
            widget.nearbyJobSeeker.name,
            style: TextStyle(
              fontFamily: 'Kayak',
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          RatingStar(widget.nearbyJobSeeker.rating),
        ],
      ),
    );
  }
}

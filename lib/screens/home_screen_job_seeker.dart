import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/provider/recommend_job.dart';
import 'package:kerjakanapp/provider/user_data.dart';
import 'package:kerjakanapp/widgets/custom_marker.dart';
import 'package:kerjakanapp/widgets/home_content.dart';
import 'package:kerjakanapp/widgets/marker_popup.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:user_location/user_location.dart';

class HomeScreenJobSeeker extends StatefulWidget {
  static const String routeName = '/home-screen-job-seeker';
  final Function changeCollapseStatus;

  HomeScreenJobSeeker({this.changeCollapseStatus});

  @override
  _HomeScreenJobSeekerState createState() => _HomeScreenJobSeekerState();
}

class _HomeScreenJobSeekerState extends State<HomeScreenJobSeeker> {
  final PopupController _popupLayerController = PopupController();
  MapController mapController = MapController();
  UserLocationOptions userLocationOptions;

  List<Marker> _nearbyJobsMarker = [];
  List<Job> _listNearbyJob = [];
  List<Job> _listRecommendJob = [];

  var _isInit = true;
  var _userData;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _userData = Provider.of<UserData>(context, listen: false).userData;

      Provider.of<NearbyJobs>(context, listen: false)
          .fetchNearbyJob()
          .then((value) {
        setState(() {
          _listNearbyJob =
              Provider.of<NearbyJobs>(context, listen: false).items;

          _listNearbyJob.forEach(
            (element) {
              _nearbyJobsMarker.add(
                Marker(
                  height: 20,
                  width: 48,
                  anchorPos: AnchorPos.align(AnchorAlign.left),
                  point: LatLng(element.latitude, element.longitude),
                  builder: (ctx) => CustomMarker(element),
                ),
              );
            },
          );
        });
      });

      Provider.of<RecommendJobs>(context, listen: false)
          .fetchRecommendJob()
          .then((value) {
        setState(() {
          _listRecommendJob =
              Provider.of<RecommendJobs>(context, listen: false).items;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: mapController,
      markers: markers,
      updateMapLocationOnPositionChange: false,
      zoomToCurrentLocationOnLoad: true,
      showMoveToCurrentLocationFloatingActionButton: false,
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: LatLng(-6.907891, 107.627825),
                zoom: 15.0,
                plugins: [
                  PopupMarkerPlugin(),
                  UserLocationPlugin(),
                ],
                onTap: (_) => _popupLayerController.hidePopup(),
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
                  additionalOptions: {
                    'accessToken':
                        'pk.eyJ1IjoiYXJheWhhbiIsImEiOiJjazdoMmNpYmkwNXlwM25xa3ZzN3Rhc2p5In0.KsW5-BlR0oim5P5D0IB9sw',
                    'id': 'mapbox/streets-v11',
                  },
                ),
                PopupMarkerLayerOptions(
                  markers: _nearbyJobsMarker,
                  popupSnap: PopupSnap.top,
                  popupController: _popupLayerController,
                  popupBuilder: (BuildContext _, Marker marker) {
                    final nearbyMarker = _listNearbyJob.firstWhere(
                        (nearbyJob) =>
                            nearbyJob.latitude == marker.point.latitude &&
                            nearbyJob.longitude == marker.point.longitude);
                    return MarkerPopup(marker, nearbyMarker);
                  },
                ),
                MarkerLayerOptions(markers: markers),
                // ADD THIS
                userLocationOptions,
              ],
            ),
            DraggableScrollableSheet(
              minChildSize: 0.05,
              maxChildSize: 0.9,
              builder: (context, scrollController) => HomeContent(
                  _listNearbyJob, scrollController, _listRecommendJob),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 5,
                    child: InkWell(
                      onTap: widget.changeCollapseStatus,
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Icon(
                            Icons.menu,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 5,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      height: 40,
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _userData['name'],
                                style: TextStyle(
                                  fontFamily: 'Kayak',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
//                              Text(
//                                '8 Pekerjaan diajukan',
//                                style: TextStyle(
//                                  fontFamily: 'Kayak',
//                                  fontWeight: FontWeight.w600,
//                                  fontSize: 10,
//                                ),
//                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: Color(0xFF4C6DE3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: _userData['photo_url'] == 'a'
                                ? Image.asset('assets/images/avatar_a.png')
                                : _userData['photo_url'] == 'b'
                                    ? Image.asset('assets/images/avatar_b.png')
                                    : _userData['photo_url'] == 'c'
                                        ? Image.asset(
                                            'assets/images/avatar_c.png')
                                        : _userData['photo_url'] == 'd'
                                            ? Image.asset(
                                                'assets/images/avatar_c.png')
                                            : Image.network(
                                                _userData['photo_url']),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

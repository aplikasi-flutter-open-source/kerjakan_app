import 'package:flutter/material.dart';
import 'package:kerjakanapp/provider/applied_job.dart';
import 'package:kerjakanapp/provider/auth.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/provider/user_data.dart';
import 'package:kerjakanapp/widgets/item_job.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class JobSeekerList extends StatefulWidget {
  final Function changeCollapseStatus;

  JobSeekerList({this.changeCollapseStatus});

  @override
  _JobSeekerListState createState() => _JobSeekerListState();
}

class _JobSeekerListState extends State<JobSeekerList> {
  var _isInit = true;
  List<Job> _listAppliedJob = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final id = Provider.of<Auth>(context, listen: false).id;
      final userData = Provider.of<UserData>(context, listen: false).userData;
      Provider.of<AppliedJob>(context, listen: false)
          .fetchAppliedJob(userData['applied_job'])
          .then((value) {
        setState(() {
          _listAppliedJob =
              Provider.of<AppliedJob>(context, listen: false).items;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 16.0,
                    ),
                    onPressed: widget.changeCollapseStatus,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Image.asset(
                      'assets/images/ic_paper_done.png',
                      width: 10.29,
                      height: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Daftar Pekerjaan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kayak',
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Ajuan Pekerjaan',
                  style: titleStyle,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Daftar pekerjaan yang Anda ajukan',
                  style: descStyle,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              _listAppliedJob.length == 0
                  ? Center(
                      child: Image.asset(
                        'assets/images/il_empty_apllied_job.png',
                        width: 205,
                        height: 116,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            ItemJob(_listAppliedJob[index]),
                        itemCount: _listAppliedJob.length,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

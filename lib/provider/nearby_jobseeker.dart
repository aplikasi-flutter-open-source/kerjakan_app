import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kerjakanapp/helper/define_job_category.dart';

import '../helper/config.dart';

class JobSeeker {
  final int id;
  final String name;
  final List<dynamic> skills;
  final int rating;
  final String photoUrl;
  final double latitude;
  final double longitude;
  final String jobCategory;

  JobSeeker({
    @required this.id,
    @required this.name,
    @required this.skills,
    @required this.rating,
    @required this.photoUrl,
    @required this.latitude,
    @required this.longitude,
    @required this.jobCategory,
  });
}

class NearbyJobSeeker with ChangeNotifier {
  List<JobSeeker> _items = [];

  Future<void> fetchNearbyJobSeeker() async {
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);

    final fetchNearby = """
  query MyQuery {
  kerjakan_user(where: {mode: {_eq: "Mencari Pekerjaan"}, city: {_eq: "${placemark[0].subAdministrativeArea}"}}) {
    id
    name
    latitude
    longitude
    delivery_skills
    home_service_skills
    leisure_skills
    misc_skills
    personal_health_skills
    rating
    photo_url
  }
}
""";

    try {
      GraphQLClient client = Config.client.value;

      final data = await client.query(
        QueryOptions(
          documentNode: gql(fetchNearby),
        ),
      );
      final nearbyData = data.data['kerjakan_user'] as List<dynamic>;
      print('nearby jobseeker $nearbyData');

      final List<JobSeeker> loadedJobSeeker = [];

      if (nearbyData == null) {
        return;
      }

      nearbyData.forEach((nearbyJobSeeker) {
        print('${DefineJobCategory(
          homeServiceSkills: nearbyJobSeeker['home_service_skills'],
          deliverySkills: nearbyJobSeeker['delivery_skills'],
          leisureSkills: nearbyJobSeeker['leisure_skills'],
          miscSkills: nearbyJobSeeker['misc_skills'],
          personalHealthSkills: nearbyJobSeeker['personal_health_skills'],
        ).getCategory()}');

        loadedJobSeeker.add(
          JobSeeker(
            id: nearbyJobSeeker['id'],
            name: nearbyJobSeeker['name'],
            skills: [
              ...nearbyJobSeeker['delivery_skills'],
              ...nearbyJobSeeker['home_service_skills'],
              ...nearbyJobSeeker['leisure_skills'],
              ...nearbyJobSeeker['misc_skills'],
              ...nearbyJobSeeker['personal_health_skills']
            ],
            rating: nearbyJobSeeker['rating'],
            photoUrl: nearbyJobSeeker['photo_url'],
            latitude: nearbyJobSeeker['latitude'],
            longitude: nearbyJobSeeker['longitude'],
            jobCategory: DefineJobCategory(
              homeServiceSkills: nearbyJobSeeker['home_service_skills'],
              deliverySkills: nearbyJobSeeker['delivery_skills'],
              leisureSkills: nearbyJobSeeker['leisure_skills'],
              miscSkills: nearbyJobSeeker['misc_skills'],
              personalHealthSkills: nearbyJobSeeker['personal_health_skills'],
            ).getCategory(),
          ),
        );
      });

      _items = loadedJobSeeker;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Map<String, dynamic> _jobSeekerData = {
    'address': '',
    'email': '',
    'work_tools': '',
    'education_department': null,
    'education_place': null,
    'education_year': null,
    'certificate_name': null,
    'certificate_instansi': null,
    'certificate_date': null,
    'last_comment': null,
    'last_comment_by': null,
    'description': null,
    'phone_number': '',
    'las_comment_photo': null,
    'rating': 0,
  };

  Map<String, dynamic> get jobSeekerData {
    return _jobSeekerData;
  }

  Future<void> fetchJobSeekerById(String id) async {
    print('fetch lagi');

    final fetchData = """
query MyQuery {
  kerjakan_user(where: {id: {_eq: $id}}) {
    rating
    address
    email
    work_tools
    education_department
    education_place
    education_year
    certificate_name
    certificate_instansi
    certificate_date
    last_comment
    last_comment_by
    description
    phone_number
    las_comment_photo
  }
}
""";

    try {
      GraphQLClient client = Config.client.value;

      final data = await client.query(
        QueryOptions(
          documentNode: gql(fetchData),
        ),
      );
      final jobSeekerData = data.data['kerjakan_user'] as List<dynamic>;
      print('nearby jobseeker $jobSeekerData');

      if (jobSeekerData == null) {
        return;
      }

      _jobSeekerData['address'] = jobSeekerData[0]['address'];
      _jobSeekerData['email'] = jobSeekerData[0]['email'];
      _jobSeekerData['work_tools'] = jobSeekerData[0]['work_tools'];
      _jobSeekerData['education_department'] =
          jobSeekerData[0]['education_department'];
      _jobSeekerData['education_place'] = jobSeekerData[0]['education_place'];
      _jobSeekerData['education_year'] = jobSeekerData[0]['education_year'];
      _jobSeekerData['certificate_name'] = jobSeekerData[0]['certificate_name'];
      _jobSeekerData['certificate_instansi'] =
          jobSeekerData[0]['certificate_instansi'];
      _jobSeekerData['certificate_date'] = jobSeekerData[0]['certificate_date'];
      _jobSeekerData['last_comment'] = jobSeekerData[0]['last_comment'];
      _jobSeekerData['last_comment_by'] = jobSeekerData[0]['last_comment_by'];
      _jobSeekerData['description'] = jobSeekerData[0]['description'];
      _jobSeekerData['phone_number'] = jobSeekerData[0]['phone_number'];
      _jobSeekerData['las_comment_photo'] =
          jobSeekerData[0]['las_comment_photo'];
      _jobSeekerData['rating'] = jobSeekerData[0]['rating'];
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> sendCommend(String id, String comment, String commentBy,
      String commentProfile, String rating) async {
    final sendComment = """
mutation MyMutation {
  update_kerjakan_user(where: {id: {_eq: $id}}, _set: {rating: "$rating", last_comment: "$comment", last_comment_by: "$commentBy", las_comment_photo: "$commentProfile"}) {
    returning {
      rating
    }
  }
}
""";

    try {
      GraphQLClient client = Config.client.value;

      final response = await client.mutate(
        MutationOptions(documentNode: gql(sendComment)),
      );

      print('response edit profile ${response.data['update_kerjakan_user']}');

      _jobSeekerData['last_comment'] = comment;
      _jobSeekerData['last_comment_by'] = commentBy;
      _jobSeekerData['las_comment_photo'] = commentProfile;
      _jobSeekerData['rating'] = int.parse(rating);
      notifyListeners();

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  List<JobSeeker> get items {
    return [..._items];
  }
}

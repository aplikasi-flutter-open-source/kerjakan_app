import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kerjakanapp/helper/config.dart';

class Job {
  final int jobId;
  final String jobTitle;
  final String jobCategory;
  final String uploadDate;
  final String jobAddress;
  final List<dynamic> jobSkills;
  final List<String> jobTools;
  final int jobEmployerId;
  final String jobDesc;
  final double latitude;
  final double longitude;
  final int jobSalary;
  final String timeSalary;
  final List<dynamic> appliedUser;
  bool favorite;

  Job({
    @required this.jobId,
    @required this.jobTitle,
    @required this.jobCategory,
    @required this.uploadDate,
    @required this.jobAddress,
    @required this.jobSkills,
    @required this.jobTools,
    @required this.jobEmployerId,
    @required this.jobDesc,
    @required this.jobSalary,
    @required this.timeSalary,
    @required this.latitude,
    @required this.longitude,
    @required this.appliedUser,
    this.favorite = false,
  });
}

class NearbyJobs with ChangeNotifier {
  List<Job> _items = [];

  Future<void> fetchNearbyJob() async {
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);

    print('city ${placemark[0].subAdministrativeArea}');
    final fetchNearby = """
query MyQuery {
  kerjakan_vacancy(where: {city: {_eq: "${placemark[0].subAdministrativeArea}"}}) {
    address
    category
    city
    description
    employer_id
    latitude
    longitude
    salary
    salary_time
    skills
    title
    tools
    upload_date
    id
    applied_user
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
      final nearbyData = data.data['kerjakan_vacancy'] as List<dynamic>;

      final List<Job> loadedJob = [];

      if (nearbyData == null) {
        return;
      }

      nearbyData.forEach((nearbyJob) {
        loadedJob.add(Job(
          jobTitle: nearbyJob['title'],
          jobCategory: nearbyJob['category'],
          uploadDate: nearbyJob['upload_date'],
          jobAddress: nearbyJob['address'],
          jobSkills: nearbyJob['skills'],
          jobTools: [nearbyJob['tools']],
          jobEmployerId: nearbyJob['employer_id'],
          jobDesc: nearbyJob['description'],
          jobSalary: int.parse(nearbyJob['salary']),
          timeSalary: nearbyJob['salary_time'],
          latitude: nearbyJob['latitude'],
          longitude: nearbyJob['longitude'],
          jobId: nearbyJob['id'],
          appliedUser: nearbyJob['applied_user'],
        ));
      });

      _items = loadedJob;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  List<Job> get items {
    return [..._items];
  }

  Future<Map<String, dynamic>> fetchEmployerById(String id) async {
    print('fetch lagi');

    final fetchData = """
query MyQuery {
  kerjakan_user(where: {id: {_eq: $id}}) {
    name
    photo_url
    rating
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
        return null;
      }

      return jobSeekerData[0] as Map<String, dynamic>;
    } catch (error) {
      print(error);
    }
  }
}

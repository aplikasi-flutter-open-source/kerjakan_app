import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kerjakanapp/helper/config.dart';
import 'package:kerjakanapp/helper/define_job_category.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/provider/nearby_jobseeker.dart';

class AppliedUser with ChangeNotifier {
  List<JobSeeker> _items = [];

  List<JobSeeker> get items {
    return [..._items];
  }

  Future<void> fetchAppliedUser(List<dynamic> userId) async {
    final List<JobSeeker> loadedJobSeeker = [];
    print(userId);

    for (dynamic id in userId) {
      final fetch = """
query MyQuery {
  kerjakan_user(where: {mode: {_eq: "Mencari Pekerjaan"}, id: {_eq: "$id"}}) {
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

        final data = await client.query(QueryOptions(documentNode: gql(fetch)));
        final appliedData = data.data['kerjakan_user'] as List<dynamic>;

        print('appliedUser $appliedData');

        if (appliedData == null) {
          return;
        }

        loadedJobSeeker.add(
          JobSeeker(
            id: appliedData[0]['id'],
            name: appliedData[0]['name'],
            skills: [
              ...appliedData[0]['delivery_skills'],
              ...appliedData[0]['home_service_skills'],
              ...appliedData[0]['leisure_skills'],
              ...appliedData[0]['misc_skills'],
              ...appliedData[0]['personal_health_skills']
            ],
            rating: appliedData[0]['rating'],
            photoUrl: appliedData[0]['photo_url'],
            latitude: appliedData[0]['latitude'],
            longitude: appliedData[0]['longitude'],
            jobCategory: DefineJobCategory(
              homeServiceSkills: appliedData[0]['home_service_skills'],
              deliverySkills: appliedData[0]['delivery_skills'],
              leisureSkills: appliedData[0]['leisure_skills'],
              miscSkills: appliedData[0]['misc_skills'],
              personalHealthSkills: appliedData[0]['personal_health_skills'],
            ).getCategory(),
          ),
        );

        print('loadedJob ${loadedJobSeeker[0].photoUrl}');
      } catch (error) {
        print(error);
      }
    }

    _items = loadedJobSeeker;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kerjakanapp/helper/config.dart';

import 'nearby_job.dart';

class RecommendJobs with ChangeNotifier {
  List<Job> _items = [];

  List<Job> get items {
    return [..._items];
  }

  Future<void> fetchRecommendJob() async {
    final fetchRecommend = """
query MyQuery {
  kerjakan_vacancy {
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
          documentNode: gql(fetchRecommend),
        ),
      );
      final recommendData = data.data['kerjakan_vacancy'] as List<dynamic>;

      final List<Job> loadedJob = [];

      if (recommendData == null) {
        return;
      }

      recommendData.forEach((recommendJob) {
        loadedJob.add(Job(
          jobTitle: recommendJob['title'],
          jobCategory: recommendJob['category'],
          uploadDate: recommendJob['upload_date'],
          jobAddress: recommendJob['address'],
          jobSkills: recommendJob['skills'],
          jobTools: [recommendJob['tools']],
          jobEmployerId: recommendJob['employer_id'],
          jobDesc: recommendJob['description'],
          jobSalary: int.parse(recommendJob['salary']),
          timeSalary: recommendJob['salary_time'],
          latitude: recommendJob['latitude'],
          longitude: recommendJob['longitude'],
          jobId: recommendJob['id'],
          appliedUser: recommendJob['applied_user'],
        ));
      });

      _items = loadedJob;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}

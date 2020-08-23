import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kerjakanapp/helper/config.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';

class AppliedJob with ChangeNotifier {
  List<Job> _items = [];

  List<Job> get items {
    return [..._items];
  }

  Future<void> requestApplyJob(String id, List<dynamic> jobId, String id2,
      List<dynamic> prevAppliedUser) async {
    final edit = """
mutation MyMutation {
  update_kerjakan_user(where: {id: {_eq: $id}}, _set: {applied_job: $jobId}) {
    returning {
      id
    }
  }
}
""";

    try {
      GraphQLClient client = Config.client.value;

      final response = await client.mutate(
        MutationOptions(documentNode: gql(edit)),
      );

      print('response apply ${response.data['update_kerjakan_user']}');
    } catch (error) {
      print(error);
    }

    prevAppliedUser.add(int.parse(id));

    final edit2 = """
mutation MyMutation {
  update_kerjakan_vacancy(where: {id: {_eq: $id2}}, _set: {applied_user: $prevAppliedUser}) {
    returning {
      id
    }
  }
}
""";

    try {
      GraphQLClient client = Config.client.value;

      final response = await client.mutate(
        MutationOptions(documentNode: gql(edit2)),
      );

      print('response apply ${response.data['update_kerjakan_vacancy']}');
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchAppliedJob(List<dynamic> jobId) async {
    final List<Job> loadedJob = [];
    print(jobId);

    for (dynamic id in jobId) {
      final fetch = """
query MyQuery {
  kerjakan_vacancy(where: {id: {_eq: $id}}) {
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
  }
}
""";

      try {
        GraphQLClient client = Config.client.value;

        final data = await client.query(QueryOptions(documentNode: gql(fetch)));
        final appliedData = data.data['kerjakan_vacancy'] as List<dynamic>;

        print('appliedData $appliedData');

        if (appliedData == null) {
          return;
        }

        loadedJob.add(Job(
          jobTitle: appliedData[0]['title'],
          jobCategory: appliedData[0]['category'],
          uploadDate: appliedData[0]['upload_date'],
          jobAddress: appliedData[0]['address'],
          jobSkills: appliedData[0]['skills'],
          jobTools: [appliedData[0]['tools']],
          jobEmployerId: appliedData[0]['employer_id'],
          jobDesc: appliedData[0]['description'],
          jobSalary: int.parse(appliedData[0]['salary']),
          timeSalary: appliedData[0]['salary_time'],
          latitude: appliedData[0]['latitude'],
          longitude: appliedData[0]['longitude'],
          jobId: appliedData[0]['id'],
        ));

        print('loadedJob $loadedJob');
      } catch (error) {
        print(error);
      }
    }

    _items = loadedJob;
    notifyListeners();

    return loadedJob;
  }
}

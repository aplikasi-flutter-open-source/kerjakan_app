import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kerjakanapp/helper/config.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';

class Vacancies with ChangeNotifier {
  List<Job> _items = [];

  List<Job> get items {
    return [..._items];
  }

  Future<void> uploadVacancy(Map<String, dynamic> vacancyData) async {
    final upload = """
mutation MyMutation {
  insert_kerjakan_vacancy(objects: {address: "${vacancyData['address']}", category: "${vacancyData['category']}", city: "${vacancyData['city']}", description: "${vacancyData['description']}", employer_id: ${vacancyData['employer_id']}, latitude: "${vacancyData['latitude']}", longitude: "${vacancyData['longitude']}", salary: "${vacancyData['salary']}", salary_time: "${vacancyData['salary_time']}", skills: ${vacancyData['skills']}, title: "${vacancyData['title']}", tools: "${vacancyData['tools']}", upload_date: "${vacancyData['upload_date']}"}) {
    returning {
      id
    }
  }
}
""";

    try {
      GraphQLClient client = Config.client.value;

      final response = await client.mutate(
        MutationOptions(documentNode: gql(upload)),
      );
      print(response.data);

      _items.add(Job(
        jobTitle: vacancyData['title'],
        jobCategory: vacancyData['category'],
        uploadDate: vacancyData['upload_date'],
        jobAddress: vacancyData['address'],
        jobSkills: vacancyData['skills'],
        jobTools: [vacancyData['tools']],
        jobEmployerId: int.parse(vacancyData['employer_id']),
        jobDesc: vacancyData['description'],
        jobSalary: int.parse(vacancyData['salary']),
        timeSalary: vacancyData['salary_time'],
        latitude: 0,
        longitude: 0,
        jobId: 0,
        appliedUser: [],
      ));
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> getMyVacancy(String id) async {
    final getMyVacancy = """
query MyQuery {
  kerjakan_vacancy(where: {employer_id: {_eq: $id}}) {
    category
    title
    upload_date
    description
    address
    salary_time
    salary
    skills
    tools
    id
    applied_user
  }
}
""";

    try {
      GraphQLClient client = Config.client.value;

      final data = await client.query(
        QueryOptions(
          documentNode: gql(getMyVacancy),
        ),
      );
      final vacancyData = data.data['kerjakan_vacancy'] as List<dynamic>;
      print('vacancy $vacancyData');

      final List<Job> loadedVacancy = [];

      if (vacancyData == null) {
        return;
      }

      vacancyData.forEach((vacancy) {
        loadedVacancy.add(Job(
          jobTitle: vacancy['title'],
          jobCategory: vacancy['category'],
          uploadDate: vacancy['upload_date'],
          jobAddress: vacancy['address'],
          jobSkills: vacancy['skills'],
          jobTools: [vacancy['tools']],
          jobEmployerId: int.parse(id),
          jobDesc: vacancy['description'],
          jobSalary: int.parse(vacancy['salary']),
          timeSalary: vacancy['salary_time'],
          latitude: 0,
          longitude: 0,
          jobId: vacancy['id'],
          appliedUser: vacancy['applied_user'],
        ));
      });

      _items = loadedVacancy;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}

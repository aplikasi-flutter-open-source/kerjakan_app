import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kerjakanapp/helper/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData with ChangeNotifier {
  String _userMode;
  Map<String, dynamic> _userData = {};

  Map<String, dynamic> get userData {
    return _userData;
  }

  String get avatarImage {
    return _userData['photo_url'];
  }

  String get userMode {
    return _userMode == null ? 'Mencari Pekerja' : _userMode;
  }

  Future<void> setUserMode(String mode, String id) async {
    print(mode);

    final edit = """
mutation MyMutation {
  update_kerjakan_user(where: {id: {_eq: $id}}, _set: {mode: "$mode"}) {
    returning {
      mode
    }
  }
}
""";

    try {
      GraphQLClient client = Config.client.value;

      final response = await client.mutate(
        MutationOptions(documentNode: gql(edit)),
      );

      print('response edit profile ${response.data['update_kerjakan_user']}');

      _userData['mode'] = mode;
      _userMode = mode;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(_userData);
      prefs.setString('kerjakan_user_data', userData);

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> savedImage(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('profile_image', imagePath);

    _userData['photo_url'] = imagePath;
    notifyListeners();
  }

  Future<void> fetchUserData(String id, BuildContext context) async {
    final requestUserData = """
  query MyQuery {
  kerjakan_user(where: {id: {_eq: $id}}) {
    name
    photo_url
    email
    gender
    home_service_skills
    delivery_skills
    city
    born_date
    address
    latitude
    longitude
    mode
    personal_health_skills
    phone_number
    rating
    leisure_skills
    misc_skills
    certificate_instansi
    certificate_date
    certificate_name
    work_tools
    description
    education_department
    education_place
    education_year
    applied_job
  }
}
""";

    try {
      GraphQLClient client = Config.client.value;

      final data = await client.query(
        QueryOptions(
          documentNode: gql(requestUserData),
        ),
      );
      final response = data.data['kerjakan_user'] as List<dynamic>;

      print('response $response');

      _userData['name'] = response[0]['name'];
      _userData['photo_url'] = response[0]['photo_url'];
      _userData['email'] = response[0]['email'];
      _userData['gender'] = response[0]['gender'];
      _userData['home_service_skills'] = response[0]['home_service_skills'];
      _userData['delivery_skills'] = response[0]['delivery_skills'];
      _userData['personal_health_skills'] =
          response[0]['personal_health_skills'];
      _userData['leisure_skills'] = response[0]['leisure_skills'];
      _userData['misc_skills'] = response[0]['misc_skills'];
      _userData['city'] = response[0]['city'];
      _userData['born_date'] = response[0]['born_date'];
      _userData['address'] = response[0]['address'];
      _userData['latitude'] = response[0]['latitude'];
      _userData['longitude'] = response[0]['longitude'];
      _userData['mode'] = response[0]['mode'];
      _userData['phone_number'] = response[0]['phone_number'];
      _userData['rating'] = response[0]['rating'];
      _userData['certificate_instansi'] = response[0]['certificate_instansi'];
      _userData['certificate_date'] = response[0]['certificate_date'];
      _userData['certificate_name'] = response[0]['certificate_name'];
      _userData['description'] = response[0]['description'];
      _userData['work_tools'] = response[0]['work_tools'];
      _userData['education_place'] = response[0]['education_place'];
      _userData['education_department'] = response[0]['education_department'];
      _userData['education_year'] = response[0]['education_year'];
      _userData['applied_job'] = response[0]['applied_job'];

      _userMode = response[0]['mode'];

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(_userData);
      prefs.setString('kerjakan_user_data', userData);

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> requestEditUserData(
      String id, Map<String, dynamic> editData) async {
    final edit = """
mutation MyMutation {
  update_kerjakan_user(where: {id: {_eq: $id}}, _set: {name: "${editData['name']}", photo_url: "${editData['photo_url']}", gender: "${editData['gender']}", born_date: "${editData['born_date']}", phone_number: "${editData['phone_number']}", address: "${editData['address']}", description: "${editData['description']}"}) {
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

      print('response edit profile $response');

      _userData['name'] = editData['name'];
      _userData['photo_url'] = editData['photo_url'];
      _userData['gender'] = editData['gender'];
      _userData['born_date'] = editData['born_date'];
      _userData['address'] = editData['address'];
      _userData['phone_number'] = editData['phone_number'];
      _userData['description'] = editData['description'];

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(_userData);
      prefs.setString('kerjakan_user_data', userData);

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> requestEditUserSkills(
      String id, Map<String, dynamic> editData) async {
    final edit = """
mutation MyMutation {
  update_kerjakan_user(where: {id: {_eq: $id}}, _set: {delivery_skills: ${editData['delivery_skills']}, home_service_skills: ${editData['home_service_skills']}, leisure_skills: ${editData['leisure_skills']}, misc_skills: ${editData['misc_skills']}, personal_health_skills: ${editData['personal_health_skills']}, work_tools: "${editData['work_tools']}"}) {
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

      print('response edit profile $response');

      _userData['delivery_skills'] = editData['delivery_skills'];
      _userData['home_service_skills'] = editData['home_service_skills'];
      _userData['leisure_skills'] = editData['leisure_skills'];
      _userData['misc_skills'] = editData['misc_skills'];
      _userData['personal_health_skills'] = editData['personal_health_skills'];
      _userData['work_tools'] = editData['work_tools'];

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(_userData);
      prefs.setString('kerjakan_user_data', userData);

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> requestEditUserCertificate(
      String id, Map<String, dynamic> editData) async {
    final edit = """
mutation MyMutation {
  update_kerjakan_user(where: {id: {_eq: $id}}, _set: {certificate_name: ${editData['certificate_name']}, certificate_instansi: ${editData['certificate_instansi']}, certificate_date: ${editData['certificate_date']}}) {
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

      print('response edit profile $response');

      _userData['certificate_name'] = editData['certificate_name'];
      _userData['certificate_instansi'] = editData['certificate_instansi'];
      _userData['certificate_date'] = editData['certificate_date'];

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(_userData);
      prefs.setString('kerjakan_user_data', userData);

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> requestEditUserEducation(
      String id, Map<String, dynamic> editData) async {
    final edit = """
mutation MyMutation {
  update_kerjakan_user(where: {id: {_eq: $id}}, _set: {education_department: ${editData['education_department']}, education_place: ${editData['education_place']}, education_year: ${editData['education_year']}}) {
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

      print('response edit profile $response');

      _userData['education_place'] = editData['education_place'];
      _userData['education_department'] = editData['education_department'];
      _userData['education_year'] = editData['education_year'];

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(_userData);
      prefs.setString('kerjakan_user_data', userData);

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}

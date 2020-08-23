import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kerjakanapp/helper/config.dart';
import 'package:kerjakanapp/main.dart';
import 'package:kerjakanapp/screens/drawer_screen.dart';
import 'package:kerjakanapp/screens/sign_up_screen_1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _id;
  bool get isAuth {
    return id != null;
  }

  String get id {
    if (_id != null) {
      return _id;
    }

    return null;
  }

  Future<void> logOut() async {
    _id = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    print('logout');
//
//    Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
  }

  Future<bool> tryAutoLogIn() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('kerjakan_id')) {
      return false;
    }
    _id = prefs.getString('kerjakan_id');
    notifyListeners();
    return true;
  }

  Future<void> signUpCariKerja(Map<String, dynamic> signUpData) async {
    final signUp = """
mutation MyMutation {
    insert_kerjakan_user(objects: {email: "${signUpData['email']}", name: "${signUpData['name']}", gender: "${signUpData['gender']}", born_date: "${signUpData['born_date']}", phone_number: "${signUpData['phone_number']}", address: "${signUpData['address']}", city: "${signUpData['city']}", latitude: "${signUpData['latitude']}", longitude: "${signUpData['longitude']}", mode: "${signUpData['mode']}", delivery_skills: ${signUpData['delivery_skills']}, home_service_skills: ${signUpData['home_service_skills']}, personal_health_skills: ${signUpData['personal_health_skills']}, leisure_skills: ${signUpData['leisure_skills']}, misc_skills: ${signUpData['misc_skills']}, work_tools: "${signUpData['work_tools']}", photo_url: "${signUpData['photo_url']}", certificate_date: ${signUpData['certificate_date']}, certificate_instansi: ${signUpData['certificate_instansi']}, certificate_name: ${signUpData['certificate_name']}}) {
    returning {
      id
    }
  }
}
""";

    try {
      GraphQLClient client = Config.client.value;

      final response = await client.mutate(
        MutationOptions(documentNode: gql(signUp)),
      );

      print(
          'response sign up ${response.data['insert_kerjakan_user']['returning'][0]['id']}');

      _id = response.data['insert_kerjakan_user']['returning'][0]['id']
          .toString();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('kerjakan_id', _id);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> signUpCariJasa(Map<String, dynamic> signUpData) async {
    final signUp = """
mutation MyMutation {
  insert_kerjakan_user(objects: {email: "${signUpData['email']}", name: "${signUpData['name']}", photo_url: "${signUpData['photo_url']}", gender: "${signUpData['gender']}", born_date: "${signUpData['born_date']}", address: "${signUpData['address']}", phone_number: "${signUpData['phone_number']}", city: "${signUpData['city']}", latitude: "${signUpData['latitude']}", longitude: "${signUpData['longitude']}", mode: "${signUpData['mode']}"}) {
    returning {
      id
    }
  }
}
""";

    try {
      GraphQLClient client = Config.client.value;

      final response = await client.mutate(
        MutationOptions(documentNode: gql(signUp)),
      );

      print('response sign up ${response.data}');
      _id = response.data['insert_kerjakan_user']['returning'][0]['id']
          .toString();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('kerjakan_id', _id);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> signIn(String email, BuildContext context) async {
    print(email);

    final signIn = """
  query MyQuery {
  kerjakan_user(where: {email: {_eq: "$email"}}) {
    id
  }
}
""";

    try {
      GraphQLClient client = Config.client.value;

      final data = await client.query(
        QueryOptions(
          documentNode: gql(signIn),
        ),
      );
      final signResponse = data.data['kerjakan_user'] as List<dynamic>;

      if (signResponse.length == 0) {
        Navigator.of(context)
            .pushNamed(SignUpScreen1.routeName, arguments: email);
        return;
      }

      _id = signResponse[0]['id'].toString();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('kerjakan_id', _id);
      notifyListeners();

      Navigator.of(context).pushNamed(MainScreen.routeName);
    } catch (error) {
      print(error);
    }
  }
}

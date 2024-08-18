import 'dart:convert';
import 'package:http/http.dart' as http;
class Picture {
  final String large;
  final String medium;
  final String thumbnail;

  const Picture({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      large: json['large'],
      medium: json['medium'],
      thumbnail: json['thumbnail'],
    );
  }
}
class Name {
  final String first;
  final String last;

  const Name({
    required this.first,
    required this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      first: json['first'],
      last: json['last'],
    );
  }
}

class User {
  final String email;
  final Picture? picture; // Make it nullable to handle the absence of picture
  final Name? name;       // Make it nullable to handle the absence of name

  const User({
    required this.email,
    this.picture,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      picture: json['picture'] != null ? Picture.fromJson(json['picture']) : null,
      name: json['name'] != null ? Name.fromJson(json['name']) : null,
    );
  }
}


class UserService {
  Future<List<User>> getUser() async {
    final response = await http.get(Uri.parse(
        'https://randomuser.me/api?results=50'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<User> list = [];
      for (var i = 0; i < data['results'].length; i++) {
        final entry = data['results'][i];
        list.add(User.fromJson(entry));
      }
      return list;
    } else {
      throw Exception('Http failed');
    }
  }
}

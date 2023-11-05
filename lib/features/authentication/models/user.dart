// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final String uid;
  final String carbonEmissions;
  final String email;
  final String profileImage;
  final String city;
  final String password;
  final String relaxationTime;
  final String eventsJoined;
  UserModel({
    required this.name,
    required this.uid,
    required this.carbonEmissions,
    required this.email,
    required this.profileImage,
    required this.city,
    required this.password,
    required this.relaxationTime,
    required this.eventsJoined,
  });

  UserModel copyWith({
    String? name,
    String? uid,
    String? carbonEmissions,
    String? email,
    String? profileImage,
    String? city,
    String? password,
    String? relaxationTime,
    String? eventsJoined,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      carbonEmissions: carbonEmissions ?? this.carbonEmissions,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      city: city ?? this.city,
      password: password ?? this.password,
      relaxationTime: relaxationTime ?? this.relaxationTime,
      eventsJoined: eventsJoined ?? this.eventsJoined,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'carbonEmissions': carbonEmissions,
      'email': email,
      'profileImage': profileImage,
      'city': city,
      'password': password,
      'relaxationTime': relaxationTime,
      'eventsJoined': eventsJoined,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      uid: map['uid'] as String,
      carbonEmissions: map['carbonEmissions'] as String,
      email: map['email'] as String,
      profileImage: map['profileImage'] as String,
      city: map['city'] as String,
      password: map['password'] as String,
      relaxationTime: map['relaxationTime'] as String,
      eventsJoined: map['eventsJoined'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, uid: $uid, carbonEmissions: $carbonEmissions, email: $email, profileImage: $profileImage, city: $city, password: $password, relaxationTime: $relaxationTime, eventsJoined: $eventsJoined)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.uid == uid &&
      other.carbonEmissions == carbonEmissions &&
      other.email == email &&
      other.profileImage == profileImage &&
      other.city == city &&
      other.password == password &&
      other.relaxationTime == relaxationTime &&
      other.eventsJoined == eventsJoined;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      uid.hashCode ^
      carbonEmissions.hashCode ^
      email.hashCode ^
      profileImage.hashCode ^
      city.hashCode ^
      password.hashCode ^
      relaxationTime.hashCode ^
      eventsJoined.hashCode;
  }
}


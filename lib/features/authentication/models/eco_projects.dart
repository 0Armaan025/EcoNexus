// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EcoProjectModel {
  final String name;
  final String bannerImage;
  final String location;
  final String description;
  final String goal;
  final String startDate;
  final String uploaderUid;
  EcoProjectModel({
    required this.name,
    required this.bannerImage,
    required this.location,
    required this.description,
    required this.goal,
    required this.startDate,
    required this.uploaderUid,
  });

  EcoProjectModel copyWith({
    String? name,
    String? bannerImage,
    String? location,
    String? description,
    String? goal,
    String? startDate,
    String? uploaderUid,
  }) {
    return EcoProjectModel(
      name: name ?? this.name,
      bannerImage: bannerImage ?? this.bannerImage,
      location: location ?? this.location,
      description: description ?? this.description,
      goal: goal ?? this.goal,
      startDate: startDate ?? this.startDate,
      uploaderUid: uploaderUid ?? this.uploaderUid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'bannerImage': bannerImage,
      'location': location,
      'description': description,
      'goal': goal,
      'startDate': startDate,
      'uploaderUid': uploaderUid,
    };
  }

  factory EcoProjectModel.fromMap(Map<String, dynamic> map) {
    return EcoProjectModel(
      name: map['name'] as String,
      bannerImage: map['bannerImage'] as String,
      location: map['location'] as String,
      description: map['description'] as String,
      goal: map['goal'] as String,
      startDate: map['startDate'] as String,
      uploaderUid: map['uploaderUid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EcoProjectModel.fromJson(String source) =>
      EcoProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EcoProjectModel(name: $name, bannerImage: $bannerImage, location: $location, description: $description, goal: $goal, startDate: $startDate, uploaderUid: $uploaderUid)';
  }

  @override
  bool operator ==(covariant EcoProjectModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.bannerImage == bannerImage &&
        other.location == location &&
        other.description == description &&
        other.goal == goal &&
        other.startDate == startDate &&
        other.uploaderUid == uploaderUid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        bannerImage.hashCode ^
        location.hashCode ^
        description.hashCode ^
        goal.hashCode ^
        startDate.hashCode ^
        uploaderUid.hashCode;
  }
}

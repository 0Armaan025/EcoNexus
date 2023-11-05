// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EcoProject {
  final String name;
  final String bannerUrl;
  final String location;
  final String description;
  final String goal;
  final String startDate;
  final String uploaderUid;
  EcoProject({
    required this.name,
    required this.bannerUrl,
    required this.location,
    required this.description,
    required this.goal,
    required this.startDate,
    required this.uploaderUid,
  });

  EcoProject copyWith({
    String? name,
    String? bannerUrl,
    String? location,
    String? description,
    String? goal,
    String? startDate,
    String? uploaderUid,
  }) {
    return EcoProject(
      name: name ?? this.name,
      bannerUrl: bannerUrl ?? this.bannerUrl,
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
      'bannerUrl': bannerUrl,
      'location': location,
      'description': description,
      'goal': goal,
      'startDate': startDate,
      'uploaderUid': uploaderUid,
    };
  }

  factory EcoProject.fromMap(Map<String, dynamic> map) {
    return EcoProject(
      name: map['name'] as String,
      bannerUrl: map['bannerUrl'] as String,
      location: map['location'] as String,
      description: map['description'] as String,
      goal: map['goal'] as String,
      startDate: map['startDate'] as String,
      uploaderUid: map['uploaderUid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EcoProject.fromJson(String source) =>
      EcoProject.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EcoProject(name: $name, bannerUrl: $bannerUrl, location: $location, description: $description, goal: $goal, startDate: $startDate, uploaderUid: $uploaderUid)';
  }

  @override
  bool operator ==(covariant EcoProject other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.bannerUrl == bannerUrl &&
        other.location == location &&
        other.description == description &&
        other.goal == goal &&
        other.startDate == startDate &&
        other.uploaderUid == uploaderUid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        bannerUrl.hashCode ^
        location.hashCode ^
        description.hashCode ^
        goal.hashCode ^
        startDate.hashCode ^
        uploaderUid.hashCode;
  }
}

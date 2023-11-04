

class CheckBoxModel {
  final String name;
  bool? value;
  final String imageUrl;
  CheckBoxModel({
    required this.name,
    this.value = false,
    required this.imageUrl,
  });

  CheckBoxModel copyWith({
    String? name,
    bool? value,
    String? imageUrl,
  }) {
    return CheckBoxModel(
      name: name ?? this.name,
      value: value ?? this.value,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  
  @override
  String toString() => 'CheckBoxModel(name: $name, value: $value, imageUrl: $imageUrl)';

  
}
List<CheckBoxModel> checkBoxModels = [
  CheckBoxModel(name: 'Wifi', imageUrl: 'assets/images/wifiFaciliti.png'),
  CheckBoxModel(name: 'Baggage', imageUrl: 'assets/images/baggage.png'),
  CheckBoxModel(
      name: 'Power / USB Port',
      imageUrl: 'assets/images/power.png',
      value: false),
  CheckBoxModel(name: 'In-Flight Meal', imageUrl: 'assets/images/spoon.png'),
];



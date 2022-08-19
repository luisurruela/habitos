class PreferenceModel {
  String uid;
  String selectedChild;

  PreferenceModel({required this.uid, required this.selectedChild});

  factory PreferenceModel.fromJson(Map<String, dynamic> json) {
    String uid = json['uid'];
    String selectedChild = json['selectedChild'];

    return PreferenceModel(uid: uid, selectedChild: selectedChild);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['selectedChild'] = selectedChild;
    return data;
  }

  @override
  String toString() {
    return '"uid" : $uid, "selectedChild": $selectedChild}';
  }
}

class User {
  final String? displayName;
  final String email;
  final DateTime creationTime;
  final String? phoneNumber;
  final String? photoURL;
  final String uid;
  final bool hasKids;

  const User(
      {this.displayName,
      required this.email,
      required this.creationTime,
      this.phoneNumber,
      this.photoURL,
      required this.uid,
      required this.hasKids});

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'email': email,
        'creationTime': creationTime,
        'phoneNumber': phoneNumber,
        'photoUrl': photoURL,
        'uid': uid,
        'hasKids': hasKids
      };
}

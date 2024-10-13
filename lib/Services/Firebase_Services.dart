import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/user.dart';


class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> getUser(String uid) async {
    var doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      var data = doc.data()!;
      return User(
        firstName: data['firstName'],
        lastName: data['lastName'],
        email: data['email'],
        phone: data['phone'],
        role: data['role'],
      );
    }
    return null;
  }
}

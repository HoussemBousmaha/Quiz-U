import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_u/models/user.dart';

class DatabaseHelper {
  void addUser(User user) async {
    final usersCollectionRef = FirebaseFirestore.instance.collection('users');
    final userDoc = usersCollectionRef.doc();
    user.id = userDoc.id;

    final docs = await usersCollectionRef.get();
    for (var docChange in docs.docChanges) {
      final doc = docChange.doc;
      final data = doc.data();
      if (data == null || data['mobile'] == user.mobile) return;
    }

    await userDoc.set(user.toJson());
  }
}

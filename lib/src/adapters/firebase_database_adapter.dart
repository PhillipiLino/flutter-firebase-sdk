part of solfacil_tools_sdk;

class FirebaseDatabaseAdapter {
  final FirebaseFirestore firestore;

  FirebaseDatabaseAdapter(this.firestore);

  Future<CollectionReference> getCollection(String collectionName) async {
    return firestore.collection(collectionName);
  }

  Future addFieldToCollection(
    CollectionReference collectionRef,
    Map<String, Object> info, [
    String? path,
  ]) async {
    if (path != null) {
      return await collectionRef.doc(path).set(info);
    }

    return await collectionRef.add(info);
  }

  Future saveUserLogin(
    String userId,
    String email, {
    Map<String, dynamic>? aditionalInfos,
  }) async {
    try {
      final collection = await getCollection('login');
      final docRef = collection.doc(userId);
      final snapshot = await docRef.get();
      final data = snapshot.data() as Map<String, dynamic>?;
      final now = DateTime.now();
      if (data != null) {
        await docRef.update({'lastLogin': now});
        return;
      }

      await docRef.set({
        'email': email,
        'firstLogin': now,
        'lastLogin': now,
        ...(aditionalInfos ?? {})
      });
    } catch (e) {
      LogManager.shared.logError('FIREBASE_SDK: $e');
    }
  }
}

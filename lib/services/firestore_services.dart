import 'package:emart_app/consts/consts.dart';

class FirestoreServices {
  // getUsers data
  static getUser(uid) {
    return firestore
        .collection(userCollection)
        .where("id", isEqualTo: uid)
        .snapshots();
  }

  // get products according to category

  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where("p-category", isEqualTo: category)
        .snapshots();
  }

  static getSubCategories(title){
    return  firestore
        .collection(productsCollection)
        .where("p-subcategory", isEqualTo: title)
        .snapshots();
  }

// get cart
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where("added_by", isEqualTo: uid)
        .snapshots();
  }

  // delete doc

  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  // get All chat messages
  static getChatMessages(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy("created_on", descending: false)
        .snapshots();
  }

  static getAllOrder() {
    return firestore
        .collection(ordersCollection)
        .where("order_by", isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getAllWishlist() {
    return firestore
        .collection(productsCollection)
        .where("p-wishlist", arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return firestore
        .collection(chatCollection)
        .where("fromId", isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where("added_by", isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
            return value.docs.length;
      }),firestore
          .collection(productsCollection)
          .where("p-wishlist", arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),firestore
          .collection(ordersCollection)
          .where("order_by", isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      })
    ]);

    return res;
  }

  static allProducts(){
    return firestore
        .collection(productsCollection).snapshots();

  }

  static getAllFeaturesProduct(){
    return firestore
        .collection(productsCollection).where("isFeatures",isEqualTo:true  ).get();
  }
static searchProducts(title){

    return firestore.collection(productsCollection).get();
}

}

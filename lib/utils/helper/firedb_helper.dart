import 'package:cloud_firestore/cloud_firestore.dart';
// class FireDbHelper {
//   static FireDbHelper helper = FireDbHelper._();
//
//   FireDbHelper._();
//
//   FirebaseFirestore fireStore = FirebaseFirestore.instance;
//   String? docId;
//
//   void setProfile(ProfileModel profileModel) async {
//     await fireStore.collection("User").doc(AuthHelper.helper.user!.uid).set({
//       "name": profileModel.name,
//       "mobile": profileModel.mobile,
//       "email": profileModel.email,
//       "uid": AuthHelper.helper.user!.uid,
//     });
//   }
//
//   Future<ProfileModel?> getSignInProfile() async {
//     DocumentSnapshot documentData = await fireStore
//         .collection('User')
//         .doc(AuthHelper.helper.user!.uid)
//         .get();
//     if (documentData.exists) {
//       Map m1 = documentData.data() as Map;
//       ProfileModel model = ProfileModel.mapToModel(m1);
//       return model;
//     } else {
//       return null;
//     }
//   }
//
//   Future<List<ProfileModel>> getAllUser() async {
//     List<ProfileModel> profileList = [];
//     QuerySnapshot snapshot = await fireStore.collection("User").where(
//         "uid", isNotEqualTo: AuthHelper.helper.user!.uid).get();
//     List<QueryDocumentSnapshot> docList = snapshot.docs;
//
//     for (var x in docList) {
//       Map m1 = x.data() as Map;
//       String docId = x.id;
//       ProfileModel model = ProfileModel.mapToModel(m1);
//       model.uid = docId;
//       profileList.add(model);
//     }
//     return profileList;
//   }
//
//   Future<void> availableProduct(String senderId, ProductModel model) async {
//     String? id = await checkUid(senderId);
//     if (id == null) {
//       //create new product
//       DocumentReference reference = await fireStore.collection("product").add({
//         "uids": [senderId]
//       });
//       id = reference.id;
//     }
//
//     //add product
//     await fireStore.collection("product").doc(id).collection("msg").add({
//       "pName": model.pName,
//       "price": model.price,
//       "description": model.description,
//       "quantity": model.quantity,
//       "imageUrl": model.imageUrl,
//     });
//   }
//   // Future<void> availableProduct(String senderId, ProductModel model) async {
//   //   //database check as per uid
//   //   String? id = await checkUid(senderId);
//   //
//   //   if (id == null) {
//   //     //create new chat
//   //     DocumentReference reference = await fireStore.collection("Product").add({
//   //       "uids": [senderId]
//   //     });
//   //     id = reference.id;
//   //   }
//   //
//   //   //add chat
//   //   await fireStore.collection("Product").doc(id).collection("msg").add({
//   //     "pName": model.pName,
//   //     "price": model.price,
//   //     "description": model.description,
//   //     "quantity": model.quantity,
//   //     "imageUrl": model.imageUrl,
//   //   });
//   // }
//
//   Future<String?> checkUid(String senderId) async {
//     QuerySnapshot snapshot = await fireStore.collection("Chat").where(
//         "uids", isEqualTo:
//     [
//       senderId,
//
//     ]).get();
//
//     List<DocumentSnapshot> docList = snapshot.docs;
//
//     if (docList.isEmpty) {
//       QuerySnapshot snapshot = await fireStore.collection("Chat").where(
//           "uids", isEqualTo: [
//         senderId,
//       ]).get();
//
//       List<DocumentSnapshot> l1 = snapshot.docs;
//       if (l1.isEmpty) {
//         return null;
//       } else {
//         DocumentSnapshot ds2 = l1[0];
//         return ds2.id;
//       }
//     }
//     else {
//       DocumentSnapshot sp = docList[0];
//       return sp.id;
//     }
//   }
//
//   Future<void> getChatDoc(String senderId) async {
//     docId = await checkUid(senderId);
//   }
//
//   Stream<QuerySnapshot<Map>> readChat() {
//     // List<ChatModel> dataList =[];
//     // String? uId = await checkChatConversation(senderId, receiverId);
//
//     //   if(uId != null){
//     //     QuerySnapshot sp = await fireStore.collection("Chat").doc(uId).collection("msg").get();
//     //     List<DocumentSnapshot> chatList= sp.docs;
//     //
//     //     for(var x in chatList){
//     //       Map m1 = x.data() as Map;
//     //       ChatModel model = ChatModel.mapToModel(m1);
//     //       dataList.add(model);
//     //     }
//     //   }
//     // }
//     print("=============  $docId");
//     Stream<QuerySnapshot<Map>> sp = fireStore.
//     collection("Chat").
//     doc(docId).
//     collection("msg").
//     orderBy("date", descending: false).
//     snapshots();
//
//     return sp;
//   }
//
//   Future<void> deleteChat(String msgId) async {
//     await fireStore.
//     collection("Chat").
//     doc(docId).
//     collection("msg").
//     doc(msgId).
//     delete();
//   }
//
//   Stream<QuerySnapshot<Map<String, dynamic>>> getMyChatUser() {
//     return fireStore
//         .collection("Chat")
//         .where("uids", arrayContains: AuthHelper.helper.user!.uid)
//         .snapshots();
//   }
//
//   Future<ProfileModel> getUIDUsers(receiverUID) async {
//     DocumentSnapshot snapshot = await fireStore.collection("User").doc(
//         receiverUID).get();
//     Map m1 = snapshot.data() as Map;
//     ProfileModel profileModel = ProfileModel.mapToModel(m1);
//     return profileModel;
//   }
// }

class FireDbHelper {

  static FireDbHelper helper = FireDbHelper._();
   FireDbHelper._();

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final CollectionReference productsCollection = FirebaseFirestore.instance.collection('product');
  final CollectionReference cartCollection = FirebaseFirestore.instance.collection('cart');

  // Add product to Firebase
  Future<void> addProduct(String name, double price, String imageUrl, String category,String description) async {
    try {
      await productsCollection.add({
        'name': name,
        'price': price,
        'imageUrl': imageUrl,
        'category': category,
        'description': description,
      });
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  // get product from Firebase
  Future<List<QueryDocumentSnapshot>> fetchProducts() async {
    try {
      QuerySnapshot snapshot = await productsCollection.get();
      return snapshot.docs;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  // Add item to user cart
  Future<void> addToCart(String userId, String productId, int quantity) async {
    try {
      await cartCollection.add({
        'userId': userId,
        'productId': productId,
        'quantity': quantity,
      });
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  // get cart items according user
  Future<List<QueryDocumentSnapshot>> fetchCartItems(String userId) async {
    try {
      QuerySnapshot snapshot = await cartCollection.where('userId', isEqualTo: userId).get();
      return snapshot.docs;
    } catch (e) {
      print('Error fetching cart items: $e');
      return [];
    }
  }

  // Remove item from cart
  Future<void> removeFromCart(String cartItemId) async {
    try {
      await cartCollection.doc(cartItemId).delete();
    } catch (e) {
      print('Error removing from cart: $e');
    }
  }

  // Update quantity
  Future<void> updateCartQuantity(String cartItemId, int quantity) async {
    try {
      await cartCollection.doc(cartItemId).update({'quantity': quantity});
    } catch (e) {
      print('Error updating cart quantity: $e');
    }
  }

  Future<void> updateUserProfile(String userId, String name, String email) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'name': name,
        'email': email,
      });
    } catch (e) {
      print('Error updating profile: $e');
      throw e;
    }
  }
}

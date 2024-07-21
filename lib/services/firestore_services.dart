import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';

class FirestoreServices{
  // get user data
  static getUser(uid){
    return firestore.collection(usersCollection).where('id',isEqualTo:uid).snapshots();
  }
//  get products according to collection
static getProducts(category){
    return firestore.collection(productsCollection).where('p_category',isEqualTo:category).snapshots();
}
  // get subcategory
  static getSubCategory(title){
    return firestore.collection(productsCollection).where('p_subcategory',isEqualTo:title).snapshots();
  }
// get cart
static getCart(uid){
    return firestore.collection(cartCollection).where('addedby',isEqualTo: uid).snapshots();
}
// delete document
static deleteDocument(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
}
// get all chat messages
static getMessages(docId){
     return firestore.collection(chatsCollection).doc(docId)
         .collection(messagesCollection).orderBy('created_on',descending: false).snapshots();
}
static getAllorder(){
    return firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).snapshots();
}
static getWishlist(){
    return firestore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
}
static getAllMessages(){
    return firestore.collection(chatsCollection).where('fromId',isEqualTo:currentUser!.uid).snapshots();
}
static getCounts()async{
    var res= await Future.wait([
      firestore.collection(cartCollection).where('addedby',isEqualTo:currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
      firestore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
      firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).get().then((value){
        return value.docs.length;
      })
    ]);
    return res;
}
static allProducts(){
  return firestore.collection(productsCollection).snapshots();
}
static removewishlist(docId)async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
    },SetOptions(merge: true));
}
// get featured products
static getFeaturedProducts(){
    return firestore.collection(productsCollection).where('is_featured',isEqualTo:true).get();
}
static searchProducts(title){
    return firestore.collection(productsCollection).get();
}
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth=FirebaseAuth.instance;
FirebaseFirestore firestore=FirebaseFirestore.instance;
var currentUser=auth.currentUser;

//collections
const usersCollection="users";
const productsCollection="products";
const cartCollection="cart";
const chatsCollection='chats';
const messagesCollection='messages';
const ordersCollection='orders';
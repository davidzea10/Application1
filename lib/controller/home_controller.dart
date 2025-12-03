import 'package:application1/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final String collectionName = 'Produits';

  Stream<List<ProductModel>> getProducts() {
    return firebaseFirestore
        .collection(collectionName)
        .orderBy('date_creation', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<String> createProduct(ProductModel product) async {
    try {
      await firebaseFirestore
          .collection(collectionName)
          .add(product.toJson());
      return 'SUCCES';
    } catch (e) {
      return 'ERREUR: ${e.toString()}';
    }
  }

  Future<String> updateProduct(ProductModel product) async {
    try {
      await firebaseFirestore
          .collection(collectionName)
          .doc(product.id)
          .update(product.toJson());
      return 'SUCCES';
    } catch (e) {
      return 'ERREUR: ${e.toString()}';
    }
  }

  Future<String> deleteProduct(String productId) async {
    try {
      await firebaseFirestore
          .collection(collectionName)
          .doc(productId)
          .delete();
      return 'SUCCES';
    } catch (e) {
      return 'ERREUR: ${e.toString()}';
    }
  }

  Future<ProductModel?> getProductById(String productId) async {
    try {
      final doc = await firebaseFirestore
          .collection(collectionName)
          .doc(productId)
          .get();
      
      if (doc.exists) {
        return ProductModel.fromJson(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

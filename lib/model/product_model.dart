import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductModel {
  const ProductModel({
    required this.id,
    required this.nomProduit,
    required this.descriptionProduit,
    required this.prixProduit,
    this.imageUrl,
    this.categorie,
    this.stock,
    this.dateCreation,
  });

  final String id;
  final String nomProduit;
  final String descriptionProduit;
  final double prixProduit;
  final String? imageUrl;
  final String? categorie;
  final int? stock;
  final DateTime? dateCreation;

  factory ProductModel.fromJson(Map<String, dynamic> json, String id) {
    return ProductModel(
      id: id,
      nomProduit: json['nom_produit'] ?? '',
      descriptionProduit: json['description_produit'] ?? '',
      prixProduit: (json['prix_produit'] is num)
          ? (json['prix_produit'] as num).toDouble()
          : double.tryParse(json['prix_produit'].toString()) ?? 0.0,
      imageUrl: json['image_url'],
      categorie: json['categorie'],
      stock: json['stock'] is num ? (json['stock'] as num).toInt() : json['stock'],
      dateCreation: json['date_creation'] != null
          ? (json['date_creation'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom_produit': nomProduit,
      'description_produit': descriptionProduit,
      'prix_produit': prixProduit,
      if (imageUrl != null) 'image_url': imageUrl,
      if (categorie != null) 'categorie': categorie,
      if (stock != null) 'stock': stock,
      'date_creation': dateCreation != null
          ? Timestamp.fromDate(dateCreation!)
          : Timestamp.now(),
    };
  }

  ProductModel copyWith({
    String? id,
    String? nomProduit,
    String? descriptionProduit,
    double? prixProduit,
    String? imageUrl,
    String? categorie,
    int? stock,
    DateTime? dateCreation,
  }) {
    return ProductModel(
      id: id ?? this.id,
      nomProduit: nomProduit ?? this.nomProduit,
      descriptionProduit: descriptionProduit ?? this.descriptionProduit,
      prixProduit: prixProduit ?? this.prixProduit,
      imageUrl: imageUrl ?? this.imageUrl,
      categorie: categorie ?? this.categorie,
      stock: stock ?? this.stock,
      dateCreation: dateCreation ?? this.dateCreation,
    );
  }
}

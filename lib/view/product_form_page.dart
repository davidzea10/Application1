import 'package:flutter/material.dart';
import 'package:application1/model/product_model.dart';
import 'package:application1/controller/home_controller.dart';

class ProductFormPage extends StatefulWidget {
  final ProductModel? product;

  const ProductFormPage({super.key, this.product});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = HomeController();
  
  late TextEditingController _nomController;
  late TextEditingController _descriptionController;
  late TextEditingController _prixController;
  late TextEditingController _categorieController;
  late TextEditingController _stockController;
  late TextEditingController _imageUrlController;

  bool _isLoading = false;
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.product != null;
    _nomController = TextEditingController(text: widget.product?.nomProduit ?? '');
    _descriptionController = TextEditingController(text: widget.product?.descriptionProduit ?? '');
    _prixController = TextEditingController(
      text: widget.product?.prixProduit.toString() ?? '',
    );
    _categorieController = TextEditingController(text: widget.product?.categorie ?? '');
    _stockController = TextEditingController(
      text: widget.product?.stock?.toString() ?? '',
    );
    _imageUrlController = TextEditingController(text: widget.product?.imageUrl ?? '');
  }

  @override
  void dispose() {
    _nomController.dispose();
    _descriptionController.dispose();
    _prixController.dispose();
    _categorieController.dispose();
    _stockController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName est requis';
    }
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Le prix est requis';
    }
    final price = double.tryParse(value.replaceAll(',', '.'));
    if (price == null || price <= 0) {
      return 'Prix invalide';
    }
    return null;
  }

  String? _validateStock(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      final stock = int.tryParse(value);
      if (stock == null || stock < 0) {
        return 'Stock invalide';
      }
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final product = ProductModel(
      id: widget.product?.id ?? '',
      nomProduit: _nomController.text.trim(),
      descriptionProduit: _descriptionController.text.trim(),
      prixProduit: double.parse(_prixController.text.replaceAll(',', '.')),
      categorie: _categorieController.text.trim().isEmpty
          ? null
          : _categorieController.text.trim(),
      stock: _stockController.text.trim().isEmpty
          ? null
          : int.parse(_stockController.text.trim()),
      imageUrl: _imageUrlController.text.trim().isEmpty
          ? null
          : _imageUrlController.text.trim(),
      dateCreation: widget.product?.dateCreation ?? DateTime.now(),
    );

    String result;
    if (_isEditMode) {
      result = await _controller.updateProduct(product);
    } else {
      result = await _controller.createProduct(product);
    }

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (result == 'SUCCES') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditMode
                ? 'Produit modifié avec succès'
                : 'Produit créé avec succès',
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Modifier le produit' : 'Nouveau produit'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image URL
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(
                  labelText: 'URL de l\'image (optionnel)',
                  hintText: 'https://example.com/image.jpg',
                  prefixIcon: const Icon(Icons.image),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 16),

              // Nom du produit
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(
                  labelText: 'Nom du produit *',
                  hintText: 'Ex: iPhone 15 Pro',
                  prefixIcon: const Icon(Icons.shopping_bag),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => _validateRequired(value, 'Le nom'),
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description *',
                  hintText: 'Décrivez le produit...',
                  prefixIcon: const Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignLabelWithHint: true,
                ),
                validator: (value) => _validateRequired(value, 'La description'),
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 16),

              // Prix et Catégorie
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _prixController,
                      decoration: InputDecoration(
                        labelText: 'Prix *',
                        hintText: '0.00',
                        prefixIcon: const Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: _validatePrice,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _categorieController,
                      decoration: InputDecoration(
                        labelText: 'Catégorie',
                        hintText: 'Ex: Électronique',
                        prefixIcon: const Icon(Icons.category),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Stock
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(
                  labelText: 'Stock (optionnel)',
                  hintText: '0',
                  prefixIcon: const Icon(Icons.inventory_2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: _validateStock,
              ),
              const SizedBox(height: 32),

              // Bouton de soumission
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        _isEditMode ? 'Modifier' : 'Créer',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


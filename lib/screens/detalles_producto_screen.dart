import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/challenge_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ModelKit product;
  
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            Hero(
              tag: 'product-image-${product.name}',
              child: Image.network(
                product.imageUrl,
                height: 300,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.error, size: 100),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Marca y precio
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(product.brand),
                        backgroundColor: product.color.withOpacity(0.2),
                      ),
                      Text(
                        '\$${product.price}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Detalles
                  Text(
                    product.details ?? 'Descripción no disponible',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Botón de compra
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () => _showPaymentOptions(context),
                      child: const Text(
                        'COMPRAR AHORA',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return PaymentOptionsModal(
          product: product,
          onSuccess: () => _showSuccessDialog(context),
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¡Compra exitosa!'),
        content: const Text('Tu producto ha sido adquirido con éxito.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cierra el diálogo
              Navigator.pop(context); // Cierra el modo de pago
              Navigator.pop(context); // Vuelve a la pantalla anterior
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}

class PaymentOptionsModal extends StatelessWidget {
  final ModelKit product;
  final VoidCallback onSuccess;
  
  const PaymentOptionsModal({
    super.key,
    required this.product,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Método de pago',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          
          const SizedBox(height: 16),
          
          // Opción Oxxo
          PaymentOptionCard(
            icon: Icons.store,
            title: 'Pagar en Oxxo',
            onTap: () => _processPayment(context, 'Oxxo'),
          ),
          
          // Opción Tarjeta
          PaymentOptionCard(
            icon: Icons.credit_card,
            title: 'Tarjeta Visa/Mastercard',
            onTap: () => _processPayment(context, 'Tarjeta'),
          ),
          
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  void _processPayment(BuildContext context, String method) {
    // Simular procesamiento de pago
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); 
      onSuccess(); 
    });
  }
}

class PaymentOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  
  const PaymentOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 30),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
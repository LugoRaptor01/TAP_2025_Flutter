import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class ChallengeScreen extends StatelessWidget {
  final bool showAppBar; // Nuevo parámetro
  const ChallengeScreen({super.key, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? 
        AppBar(
          title: const Text('Modelos a Escala'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        )
      :null, // AppBar solo se muestra si showAppBar es true
      body: GridView.builder(

        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          
        ),

        itemCount: modelKits.length,

        itemBuilder: (context, index) {

          return ModelKitCard(modelKit: modelKits[index]);
        },
      ),
    );
  }
}

class ModelKitCard extends StatelessWidget {
  final ModelKit modelKit;

  const ModelKitCard({super.key, required this.modelKit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: modelKit.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Contenido principal
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen del modelo
                Expanded(
                  flex: 5,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        modelKit.imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => 
                          const Icon(Icons.error, color: Colors.white, size: 50),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Nombre del modelo
                Text(
                  modelKit.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Detalles del modelo
                /*Text(
                  modelKit.details,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )*/
                const SizedBox(height: 12),
                // Precio y botón
                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      '\$${modelKit.price}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    ElevatedButton(
                      onPressed: ( ) {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: modelKit.color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8
                        ),
                      ),
                      child: const Text('Detalles'),
                    ),

                  ],
                ),

              ],
            ),

          ),

          // Etiqueta de marca si existe
          if (modelKit.brand.isNotEmpty)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  modelKit.brand,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ModelKit {
  final String name;
  //final String details;
  final String imageUrl;
  final Color color;
  final String price;
  final String brand;

  ModelKit({
    required this.name,
    //required this.details,
    required this.imageUrl,
    required this.color,
    required this.price,
    this.brand = '',
  });
}

final List<ModelKit> modelKits = [
  ModelKit(
    name: 'GWH F-14D Tomcat',
    //details: '1/72 Scale Model Kit #K7201',
    imageUrl: 'https://m.media-amazon.com/images/I/61lkqZT17TL._AC_SX679_.jpg',
    color: const Color(0xFF37474F),
    price: '599.99',
    brand: 'GWH',
  ),

  ModelKit(
    name: 'Revell Spitfire Mk.II',
    //details: '1/48 Scale #03959 - Germany',
    imageUrl: 'https://m.media-amazon.com/images/I/61MU0p2xuKL._AC_SL1500_.jpg',
    color: const Color(0xFF37474F),
    price: '665.00',
    brand: 'Revell',
  ),

  ModelKit(
    name: 'Revell F-16CJ Fighting Falcon',
    //details: '1/144 Scale #60724',
    imageUrl: 'https://m.media-amazon.com/images/I/613IZDJzZ5L._AC_SX679_.jpg',
    color: const Color(0xFF37474F),
    price: '549.99',
    brand: 'Revell',
  ),

  ModelKit(
    name: 'Airfix Messerschmitt Bf 109E-4',
    //details: '1/72 Scale #A01071',
    imageUrl: 'https://http2.mlstatic.com/D_NQ_NP_966840-MLM81977168472_022025-O.webp',
    color: const Color(0xFF37474F),
    price: '399.99',
    brand: 'Airfix',
  ),

  ModelKit(
    name: 'Italeri Sukhoi Su-34/Su-32',
    //details: '1/72 Scale #1379',
    imageUrl: 'https://http2.mlstatic.com/D_NQ_NP_2X_639089-MLM31921022130_082019-F.webp',
    color: const Color(0xFF37474F),
    price: '837.25',
    brand: 'Italeri',
  ),

];
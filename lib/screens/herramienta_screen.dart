import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/challenge_screen.dart';

class ToolsScreen extends StatelessWidget {
  final bool showAppBar;
  const ToolsScreen({super.key, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: showAppBar
      ? AppBar(

        title: const Text('Herramienta'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context)
        ),
      )
      :null,
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: tools.length,
        itemBuilder: (context, index) {
          return ModelKitCard(modelKit: tools[index]); // Cambiado de Herramientas[index] a tools[index]
        },
      ),
    );
  }
}

// Cambia la clase Herramientas por ModelKit (elimínala y usa ModelKit)
final List<ModelKit> tools = [
  ModelKit(
    name: 'Pinzas en ángulo',
    //details: 'Par de pinzas en ángulo de acero inoxidable.',
    imageUrl: 'https://m.media-amazon.com/images/I/51AAbG5sjaL._AC_SL1500_.jpg',
    color: const Color.fromARGB(255, 44, 39, 38),
    price: '485.17',
    brand: 'Tamiya',
  ),

  ModelKit(
    name: 'Pinza de corte',
    //details: 'Par de pinzas de corte para plástico de acero inoxidable.',
    imageUrl: 'https://m.media-amazon.com/images/I/41-oSlx3TXL._AC_SL1200_.jpg',
    color: const Color.fromARGB(255, 44, 39, 38),
    price: '1056.32',
    brand: 'Tamiya',
  ),

  ModelKit(
    name: 'Cutter Exacto',
    //details: 'Cutter de tipo exacto con puntas de acero inoxidable para modelos de plástico.',
    imageUrl: 'https://m.media-amazon.com/images/I/61kK2OXJj9L._AC_SL1500_.jpg',
    color: const Color.fromARGB(255, 44, 39, 38),
    price: '508.34',
    brand: 'Tamiya',
  ),

  ModelKit(
    name: 'Tapete de corte',
    //details: 'Tapete de corte para manualidades con guias de 45 x 30 cm (Verde).',
    imageUrl: 'https://m.media-amazon.com/images/I/81GOxg31u9L._AC_SL1500_.jpg',
    color: const Color.fromARGB(255, 44, 39, 38),
    price: '299.00',
    brand: 'Seafon',
  ),

  ModelKit(
    name: 'Manos Extras con lupa',
    //details: 'Soporte de apoyo para modelismo con pinzas ',
    imageUrl: 'https://http2.mlstatic.com/D_NQ_NP_2X_914305-MLM81547846991_122024-F-manos-extras-c-lupa-modelismo-tamiya-revell-italeri-testors.webp',
    color: const Color.fromARGB(255, 44, 39, 38),
    price: '289.00',
    brand: 'Helping Hand',
  ),

  ModelKit(
    name: 'Kit profesional de aerógrafo para modelismo',
    //details: 'Kit de aerografo profesional. Incluye estación de bombeo eléctrica, cambios de boquillas y escobillas de limpieza.',
    imageUrl: 'https://http2.mlstatic.com/D_NQ_NP_2X_639485-CBT81276948146_122024-F.webp',
    color: const Color.fromARGB(255, 44, 39, 38),
    price: '1084.91',
    brand: 'Genérico',
  ),


];
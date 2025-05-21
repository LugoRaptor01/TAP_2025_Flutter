import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/challenge_screen.dart';

class ConsumiblesScreen extends StatelessWidget {
  final bool showAppBar;
  const ConsumiblesScreen({super.key, this.showAppBar = true});

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
        itemCount: consumibles.length,
        itemBuilder: (context, index) {
          return ModelKitCard(modelKit: consumibles[index]); // Cambiado de Herramientas[index] a tools[index]
        },
      ),
    );
  }
}

final List <ModelKit> consumibles = [

  ModelKit(
    name: 'Pinzas en ángulo',
    details: 'Par de pinzas en ángulo de acero inoxidable.',
    imageUrl: 'https://m.media-amazon.com/images/I/51AAbG5sjaL._AC_SL1500_.jpg',
    color: const Color.fromARGB(255, 117, 116, 62),
    price: '485.17',
    brand: 'Tamiya',
  ),

];
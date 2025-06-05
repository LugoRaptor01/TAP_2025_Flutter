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

        title: const Text('Consumibles'),
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
    name: 'Set de pinturas acrílicas Testors',
    //details: '',
    imageUrl: 'https://http2.mlstatic.com/D_NQ_NP_2X_896035-MLM71021931544_082023-F-pinturas-acrilicas-acrilico-9-piezas.webp',
    color: const Color.fromARGB(255, 117, 116, 62),
    price: '1234.46',
    brand: 'Testors',
  ),

  ModelKit(
    name: 'Pegamento Cemento para plástico',
    //details: 'Cemento pegamento para plástico estireno.',
    imageUrl: 'https://http2.mlstatic.com/D_NQ_NP_936738-MLM78932971267_092024-O-tamiya-pegamento-cemento-20-ml-revell-italeri-testors-amt.webp',
    color: const Color.fromARGB(255, 117, 116, 62),
    price: '179.00',
    brand: 'Tamiya',
  ),

  ModelKit(
    name: 'Cinta Masking Tape 3mm 2 piezas',
    //details: 'Cinta masking tape para modelismo de 3mm',
    imageUrl: 'https://http2.mlstatic.com/D_NQ_NP_2X_981618-MLM76131002964_052024-F-italeri-masking-tape-3-mm-2-pzs-18m-cu-modelistas-modelismo.webp',
    color: const Color.fromARGB(255, 117, 116, 62),
    price: '199.00',
    brand: 'Italeri',
  ),

  ModelKit(
    name: 'Set de lijas de acabado fino.',
    //details: 'Set de lijas para modelismo de acabado fino de 400, 600 y 1000',
    imageUrl: 'https://http2.mlstatic.com/D_NQ_NP_2X_999433-MLM31367692074_072019-F-tamiya-set-lijas-para-modelismo-acabado-fino-400-600-1000.webp',
    color: const Color.fromARGB(255, 117, 116, 62),
    price: '215.00',
    brand: 'Tamiya',
  ),

];

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class JuiceWidget extends StatefulWidget {
  @override
  _JuiceWidgetState createState() => _JuiceWidgetState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challenge App')
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: JuiceWidget()
        ),      
      )
    );
  }
}

  class _JuiceWidgetState extends State<JuiceWidget> {
  @override
  Widget build(BuildContext context) {
    
    final txtStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    return AspectRatio(
      aspectRatio: 1.25,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final topPadding = constraints.maxHeight * 0.2;
          final leftPadding = constraints.maxWidth * 0.1;
          final imageWidth = constraints.maxWidth * 0.35;
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: topPadding),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 8, 7, 100),
                  borderRadius: BorderRadius.circular(24),
                ),

              ),
              
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 40.0,
                        left: leftPadding,
                        right: 10.0
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'GWH F-14D Tomcat 1/72 scale kit',
                            style: txtStyle.copyWith(fontSize: 20),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '\$',
                                  style: txtStyle.copyWith(fontSize: 16),
                                ),
                                TextSpan(
                                  text: '199.99',
                                  style: txtStyle.copyWith(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 120,
                            child: MyButton(
                              text: 'Buy Now',
                              textColor: Color(0xFFDC691F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                  width: imageWidth,
                  child: Image.network(
                    "https://finescale.com/~/media/images/workbench-reviews/2020/october-2020-workbench-reviews/fsmwb1020_gwh_f14d_tomcat_01.jpg",
                    fit: BoxFit.contain,
                    ),

                  ),

                ],
              ),

            ],
          );
        }
      )
    );
  }
}

// ✅ MyButton Widget funcional
class MyButton extends StatelessWidget {
  final String text;
  final Color textColor;

  const MyButton({
    super.key,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pressed "$text"!')),
        );
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      child: Text(text),
    );
  }
}

class JuiceEntity {
  final String name;
  final String image;
  final String price;
  final Color color;

  JuiceEntity({
    required this.name,
    required this.image,
    required this.price,
    required this.color,
  });
}

final juiceList = [
  JuiceEntity(
    name: 'Besom Yellow Juice',
    image: 'https://finescale.com/~/media/images/workbench-reviews/2020/october-2020-workbench-reviews/fsmwb1020_gwh_f14d_tomcat_01.jpg',
    price: '119.99',
    color: Color(0xFFF3BE39),
  ),
  JuiceEntity(
    name: 'Besom Orange Juice',
    image: 'https://flutter4fun.com/wp-content/uploads/2021/09/juice2.png',
    price: '25.99',
    color: Color(0xFFDC691F),
  ),
];

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          padding: EdgeInsets.all(20),
          itemBuilder: (context, index) {
            return JuiceWidget();
          },
          itemCount: juiceList.length,
        ),
      ),
    );
  }
}
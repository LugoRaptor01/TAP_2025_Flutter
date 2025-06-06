import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/popular_model.dart';
import 'package:flutter_application_2/network/api_popular.dart';
import 'package:flutter_application_2/screens/detailed_popular_movie.dart';

class PopularScreen extends StatefulWidget{

  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen>{

  ApiPopular? apiPopular;
  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    //apiPopular!.getPopularMovies();
  }

  @override
  
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      ),
      body: FutureBuilder(
        future: apiPopular!.getPopularMovies(),
        builder: (context, snapshot) {

          if (snapshot.hasData){

            return ListView.separated(

              padding: EdgeInsets.symmetric(horizontal: 10),
              separatorBuilder: (context, index) => SizedBox(height: 10,),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                
                return ItemPopular(snapshot.data![index]);
              },
            );
            
          } else {

            if (snapshot.hasError) {

              return Center(child: Text(snapshot.error.toString()),);
            } else {

              return Center(child: CircularProgressIndicator(),);
            }
          }
        }
      ),
    );
  }

  Widget ItemPopular(PopularModel popular) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Hero(
              tag: 'backdrop-${popular.id}',
              child: AspectRatio(
                aspectRatio: 16/9,
                child: FadeInImage(
                  placeholder: AssetImage('assets/loading_api.gif'),
                  image: NetworkImage(popular.backdropPath),
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[800],
                    child: Center(
                      child: Icon(Icons.broken_image, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 50,
                color: Colors.black.withOpacity(0.6),
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailedPopularMovie(),
                      settings: RouteSettings(arguments: popular),
                    ),
                  ),
                  title: Text(
                    popular.title, 
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black,
                          offset: Offset(1, 1),
                        )
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
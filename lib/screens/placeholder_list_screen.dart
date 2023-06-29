import 'package:flutter/material.dart';
import 'package:sportinfo/model/sport_fact.dart';
class PlaceholderListScreen extends StatelessWidget {
  const PlaceholderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: facts.length,
            itemBuilder: (context ,index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, 'PlaceholderScreen',
                        arguments: facts[index]);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width -16,
                    height: MediaQuery.of(context).size.height /4,
                    decoration: BoxDecoration(
                      boxShadow: const [BoxShadow(
                          offset: Offset(4.0, 4.0),
                          blurRadius: 8.0,
                          color: Colors.black54)],
                      borderRadius: BorderRadius.circular(35),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        tileMode: TileMode.mirror,
                        colors: [
                          Color(0xFFD0F5BE),
                          Color(0xFFB3C99C),
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/weather.png',
                            image: facts[index].img,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width /2 -16,
                            height: MediaQuery.of(context).size.height /4,
                            imageErrorBuilder: (context, error, trace) =>
                            const CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width /2 - 16,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(facts[index].title.toUpperCase(),
                              style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              overflow: TextOverflow.ellipsis,

                            ),
                              maxLines: 8,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}

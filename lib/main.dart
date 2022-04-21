import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieshub/assets/assets.dart';
import 'package:movieshub/requests.dart';
import 'package:movieshub/widgets/textWidget.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    Requests.fetchData();
  }
  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoviesHub',
      home: Scaffold(
          appBar: AppBar(title: const Center(child:Text('MoviesHub'),),
            backgroundColor: ColorAssets.appBarClr,),
          backgroundColor:ColorAssets.appBg ,
          body: SafeArea(
            child:Container(
            margin: const EdgeInsets.all(10.0),
            child: ListView.builder(
                itemCount: Requests.data.length,
                itemBuilder: (BuildContext context,index){
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Image.network(
                          Requests.imageUrl+Requests.data[index]['poster_path'],
                          fit: BoxFit.contain,
                        ),
                        title: TextWidget(
                          txt: Requests.data[index]['title'],
                          txtWeight: FontWeight.bold,
                          txtSize: FontSizes.titleSize,
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                const TextWidget(txt: "Language :",
                                txtWeight: FontWeight.bold,),
                                TextWidget(txt:Requests.data[index]["original_language"],
                                  txtWeight: FontWeight.bold,),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                const TextWidget(txt: "Vote :",
                                  txtWeight: FontWeight.bold,),
                                TextWidget(txt:Requests.data[index]["vote_average"].toString(),
                                  txtWeight: FontWeight.bold,),
                                const Icon(
                                  Icons.star,
                                  size: IconSizes.starSize,
                                  color: ColorAssets.starIconClr,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                const TextWidget(txt: "Popular :",
                                  txtWeight: FontWeight.bold,),
                                TextWidget(txt:Requests.data[index]["popularity"].toString(),
                                  txtWeight: FontWeight.bold,),
                              ],

                            ),
                          ],
                        ),

                        ),
                      ButtonBar(
                        children: <Widget>[
                          GestureDetector(
                            onTap:(){},
                            child: const Text('Details',style: TextStyle(color: ColorAssets.linkTxtClr),),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
            }),

          )
          ),
      ),
    );


  }
}

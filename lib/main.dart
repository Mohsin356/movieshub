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
  }
  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoviesHub',
      home: Scaffold(
          appBar: AppBar(title: const Center(child:Text('MoviesBox'),),
            backgroundColor: ColorAssets.appBarClr,),
          backgroundColor:ColorAssets.appBg ,
          body: SafeArea(
            child:Container(
            margin: const EdgeInsets.all(10.0),
            child: FutureBuilder<String>(
            future: Requests.fetchData(), // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              // print(snapshot.connectionState);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ColorAssets.circularIndicatorClr)),);
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return LayoutBuilder(builder: (context, constraints) {
                    return
                    GridView.builder(
                        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: constraints.maxWidth > 700 ? 3 : 1,
                          childAspectRatio:constraints.maxWidth > 700 ? 2: 5,
                        ),
                        itemCount: Requests.data.length,
                        itemBuilder: (BuildContext context, index) {
                          return
                            Card(
                              child:
                              SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: Image.network(
                                        Requests.imageUrl +
                                            Requests.data[index]['poster_path'],
                                        fit: BoxFit.contain,
                                      ),
                                      title: TextWidget(
                                        txt: Requests.data[index]['title'],
                                        txtWeight: FontWeight.bold,
                                      ),
                                      subtitle: Column(
                                        children: [
                                          Row(
                                            children: <Widget>[
                                              const TextWidget(
                                                txt: "Language :",
                                                txtWeight: FontWeight.bold,),
                                              TextWidget(txt: Requests
                                                  .data[index]["original_language"],
                                                txtWeight: FontWeight.bold,),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              const TextWidget(txt: "Vote :",
                                                txtWeight: FontWeight.bold,),
                                              TextWidget(
                                                txt: Requests
                                                    .data[index]["vote_average"]
                                                    .toString(),
                                                txtWeight: FontWeight.bold,),
                                              const Icon(
                                                Icons.star,
                                                color: ColorAssets.starIconClr,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              const TextWidget(txt: "Popular :",
                                                txtWeight: FontWeight.bold,),
                                              TextWidget(
                                                txt: Requests
                                                    .data[index]["popularity"]
                                                    .toString(),
                                                txtWeight: FontWeight.bold,),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                        });
                  });
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
        )
          )
          ),
      ),
    );
  }
}

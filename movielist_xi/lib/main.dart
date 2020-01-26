import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movielist_xi/addmovie.dart';
import 'package:movielist_xi/editMovie.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Movie Lists'),
        backgroundColor: Colors.yellow,
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('MovieList').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return new Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return new MovieList(
            document: snapshot.data.documents,
          );
        },
      ),
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow,
        onPressed: () {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => AddMovie()));
        },
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  MovieList({this.document});

  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
        String Movie_Title = document[i].data['Movie_Title'].toString();
        String Movie_Rate = document[i].data['Movie_Rate'].toString();
        String Movie_Year_Release =
            document[i].data['Movie_Year_Release'].toString();

        return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                new Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Movie_Title,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(Movie_Rate),
                        Text(Movie_Year_Release),
                      ],
                    ),
                  ),
                ),
                new IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => EditMovie(
                              movieTitle: Movie_Title,
                              movieRate: Movie_Rate,
                              movieRelease:
                                  document[i].data['Movie_Year_Release'],
                              index: document[i].reference,
                            )));
                  },
                ),
              ],
            ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddMovie extends StatefulWidget {
  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  String movieTitle = '';
  String movieRate = '';
  int movieRelease;

  void _addData() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          Firestore.instance.collection('MovieList');
      await reference.add({
        "Movie_Title": movieTitle,
        "Movie_Rate": movieRate,
        "Movie_Year_Release": movieRelease,
        "timestamp": DateTime.now(),
      });
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Movie'),
          backgroundColor: Colors.yellow,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLength: 50,
                  decoration: new InputDecoration(
                    hintText: 'Movie Title',
                    hintMaxLines: 50,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (str) {
                    setState(() {
                      movieTitle = str;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: new InputDecoration(
                    hintText: 'Movie Year Release',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (year) {
                    setState(() {
                      movieRelease = num.tryParse(year);
                    });
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Movie Rate'),
                  ListTile(
                    title: const Text('G'),
                    leading: Radio(
                      value: 'G',
                      groupValue: movieRate,
                      onChanged: (value) {
                        setState(() {
                          movieRate = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('PG'),
                    leading: Radio(
                      value: 'PG',
                      groupValue: movieRate,
                      onChanged: (value) {
                        setState(() {
                          movieRate = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('M'),
                    leading: Radio(
                      value: 'M',
                      groupValue: movieRate,
                      onChanged: (value) {
                        setState(() {
                          movieRate = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('MA'),
                    leading: Radio(
                      value: 'MA',
                      groupValue: movieRate,
                      onChanged: (value) {
                        setState(() {
                          movieRate = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('R'),
                    leading: Radio(
                      value: 'R',
                      groupValue: movieRate,
                      onChanged: (value) {
                        setState(() {
                          movieRate = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              RaisedButton(
                onPressed: () {
                  _addData();
                },
                child: Text('Save'),
                color: Colors.yellow,
              )
            ],
          ),
        ));
  }
}

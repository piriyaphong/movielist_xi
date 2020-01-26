import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

  enum LocalUser { MANAGER, TEAMLEADER, FLOORSTAFF}

class EditMovie extends StatefulWidget {
  EditMovie({this.movieTitle, this.movieRate, this.movieRelease, this.index});
  String movieTitle;
  String movieRate;
  int movieRelease;
  final index;
  @override
  _EditMovieState createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {
  TextEditingController controllerTitle;
  TextEditingController controllerRate;
  TextEditingController controllerRelease;

  String movieTitle;
  String movieRate;
  int movieRelease;

  void _editmovie() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "Movie_Title": movieTitle,
        "Movie_Rate": movieRate,
        "Movie_Year_Release": movieRelease,
        "timestamp": DateTime.now()
      });
    });
  }

  void _deleteMovie() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.delete(widget.index);
    });
    
    Navigator.pop(context);
  }


 
Future<LocalUser> _asyncSimpleDialog(BuildContext context) async {
  return await showDialog<LocalUser>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select User '),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
               _deleteMovie();
               Navigator.pop(context);
              },
              child: const Text('Manager'),
            ),
            SimpleDialogOption(
              onPressed: () {                
              },
              child: const Text('Team leader'),
            ),
            SimpleDialogOption(
              onPressed: () {             
              },
              child: const Text('Floor Staff'),
            ),
            
          ],
        );
        
      });
      
      
}

  @override
  void initState() {
    super.initState();

    movieTitle = widget.movieTitle;
    movieRate = widget.movieRate;
    movieRelease = widget.movieRelease;

    controllerTitle = new TextEditingController(text: widget.movieTitle);
    controllerRate = new TextEditingController(text: widget.movieRate);
    controllerRelease =
        new TextEditingController(text: widget.movieRelease.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Edit Movie'),
          backgroundColor: Colors.yellow,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controllerTitle,
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
                  controller: controllerRelease,
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
                          //controllerRate = value;
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
                          //controllerRate = value;
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
                          //controllerRate = value;
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
                          //controllerRate = value;
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
                  _editmovie();
                },
                child: Text('Save'),
                color: Colors.yellow,
              ),
              RaisedButton(
                onPressed: () async {
                    final LocalUser usrName = await _asyncSimpleDialog(context);
                    print("Selected User is $usrName");
                },
                child: Text('Delete'),
                color: Colors.red,
              ),
            ],
          ),
        ));
  }
}

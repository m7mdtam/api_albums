// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_1/model/album.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Album>> getdata() async {
    var url = "https://jsonplaceholder.typicode.com/albums";
    var jsonData = await http.get(Uri.parse(url));

    if (jsonData.statusCode == 200) {
      List data = jsonDecode(jsonData.body);

      List<Album> allusers = [];
      for (var u in data) {
        Album album = Album.fromjson(u);
        allusers.add(album);
      }
      return allusers;
    } else {
      throw Exception("error");
    }
  }

  late Future<List<Album>> users;
  @override
  void initState() {
    super.initState();
    users = getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: FutureBuilder<List<Album>>(
          future: users,
          builder: (context, snapShout) {
            if (snapShout.hasData) {
              return ListView.builder(
                itemCount: snapShout.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    child: Card(
                      elevation: 5,
                      child: Text(
                          "Id : ${snapShout.data![index].id}\n title : ${snapShout.data![index].title}"),
                    ),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

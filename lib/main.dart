import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DataFrontAPI(),
  ));
}

class DataFrontAPI extends StatefulWidget {
  @override
  State<DataFrontAPI> createState() => _DataFrontAPIState();
}

class _DataFrontAPIState extends State<DataFrontAPI> {
  List<User> users = [];

  Future getUserData() async {
    var response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    print(response.statusCode==200);
    var jsonData = jsonDecode(response.body);
    for (var u in jsonData) {
      User user = User(u["name"], u["email"], u["username"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('user data'),
      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.data! == null) {
                return Container(
                  child: Center(
                    child: Text('Loading...'),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(users[i].name),
                        subtitle: Text(users[i].userName),
                        trailing: Text(users[i].email),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}

class User {
  final String name, email, userName;
  User(
    this.name,
    this.email,
    this.userName,
  );
}

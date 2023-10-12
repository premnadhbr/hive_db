import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Box box = Hive.box('friend');

  String? name;
  addFriend() async {
    await box.put('myname', 'Premnadh');
  }

  getFriend() async {
    setState(() {
      name = box.get('myname');
    });
  }

  updateFriend() async {
    await box.put('myname', 'elonmusk');
  }

  deleteFriend() async {
    await box.delete('myname');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$name'),
            ElevatedButton(onPressed: addFriend, child: const Text('Create')),
            ElevatedButton(onPressed: getFriend, child: const Text('Read')),
            ElevatedButton(
                onPressed: updateFriend, child: const Text('Update')),
            ElevatedButton(onPressed: deleteFriend, child: const Text('Delete'))
          ],
        ),
      ),
    );
  }
}

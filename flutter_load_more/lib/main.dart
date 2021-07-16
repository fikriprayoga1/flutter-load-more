import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List dummyList;
  late ScrollController _scrollController = ScrollController();
  int _currentMax = 10;

  @override
  void initState() {
    super.initState();
    dummyList = List.generate(10, (index) => 'Item : ${index + 1}');
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreList();
      }
    });
  }

  _getMoreList() {
    print('Get More List');
    for (var i = _currentMax; i < _currentMax + 10; i++) {
      dummyList.add("Item : ${i + 1}");
    }
    _currentMax += 10;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lazy Loading'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemExtent: 75, // How long space between item if all item not fill all screen
        itemBuilder: (context, index) {
          if (index == dummyList.length) {
            return CupertinoActivityIndicator();
          }
          return ListTile(
            title: Text(dummyList[index]),
          );
        },
        itemCount: dummyList.length + 1,
      ),
    );
  }
}

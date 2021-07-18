import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'network.dart';

class JsonParsingSimple extends StatefulWidget {
  const JsonParsingSimple({Key? key}) : super(key: key);

  @override
  _JsonParsingSimpleState createState() => _JsonParsingSimpleState();
}

class _JsonParsingSimpleState extends State<JsonParsingSimple> {
  Future? data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // data = Network("https://jsonplaceholder.typicode.com/posts").fetchData();
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body: Center(
        child: FutureBuilder(
          future: getData(),
          builder: (context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return createListView(snapshot.data, context);
              //return Text(snapshot.data[0]['userId'].toString());
            }else{
              return CircularProgressIndicator();
            }

          },
        ),
      ),
    );
  }
  Future getData() async{
    var data;
    String url = "https://jsonplaceholder.typicode.com/posts";
    Network network = Network(url);
    data = network.fetchData();
     // print(data); // this gives 'Future<dynamic>'
    // to resolve
    // data.then((value){
    //   //print(value);
    //   print(value[0]['title']);
    // });
    return data;
  }

  Widget createListView(List data, BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: data.length,
          itemBuilder:(context, int index){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(height: 5.0,),
            ListTile(
              title: Text("${data[index]['title']}"),
              subtitle: Text("${data[index]['body']}"),
              leading: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black26,
                    radius: 23,
                    child: Text("${data[index]["id"]}"),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

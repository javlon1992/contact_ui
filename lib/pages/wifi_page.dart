import 'package:flutter/material.dart';

class WiFiPage extends StatefulWidget {
  static String id="wifi_page";
  const WiFiPage({Key? key}) : super(key: key);

  @override
  _WiFiPageState createState() => _WiFiPageState();
}

class _WiFiPageState extends State<WiFiPage> {
   bool _OnOff = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: Center(child: Text("WiFi",style: TextStyle(fontWeight: FontWeight.w400),)),
        actions: [
          Switch(
            value: _OnOff,
            onChanged: (value){
              setState(() {
                _OnOff=value;
                print(_OnOff);
              });
            },
            activeTrackColor: Colors.white,
            activeColor: Colors.indigoAccent,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, int index) {
          return ListTile(
            leading: Icon(Icons.wifi),
            title: Text("Name WiFi"),
             trailing: Container(
               width: 100,
               child: Row(
                 children: [
                   IconButton(
                     onPressed: () { }, icon: Icon(Icons.lock,size: 15,),),
                   IconButton(
                     onPressed: () { }, icon: Icon(Icons.arrow_forward_ios,size: 15,),),
                 ],
               ),
             ),
          );
        },

      ),
    );
  }
}
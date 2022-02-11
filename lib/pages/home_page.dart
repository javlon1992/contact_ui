
import 'package:contact_ui/pages/contact_page.dart';
import 'package:contact_ui/pages/wifi_page.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget{
  static String id = "home_page";
  Iterable<Contact> _contacts = [];

  Iterable<Contact> get phoneContact => _contacts;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Check contacts permission
  @override
  void initState() {
    super.initState();
    _askPermissions(null);
    // _getContacts();
  }

  Future<void> _askPermissions(String? routeName) async{
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if (routeName != null) {
        Navigator.of(context).pushReplacementNamed(routeName);
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: const Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar = SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              minWidth: 200,
              shape: StadiumBorder(),
              color: Colors.blue,
              onPressed: () {
                //Navigator.pushNamed(context, ContactPage.id);
                _askPermissions(ContactPage.id);
              },
              child: Text(
                "Contacts",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 15,),
            MaterialButton(
              minWidth: 200,
              shape: StadiumBorder(),
              color: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, WiFiPage.id);
              },
              child: Text(
                "WiFi",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  static String id = "contact_page";

  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();


}

class _ContactPageState extends State<ContactPage> {

  Iterable<Contact> _contacts = [];
  List<Color> colors = Colors.accents;
  // List<Contact> contacts = [
  //   Contact("Sanjar", "+998946941428"),
  //   Contact("Fayoz", "+998930000342"),
  //   Contact("Ravshan", "+998996062841"),
  //   Contact("Sardor", "+998907997720"),
  //   Contact("Donyor", "+998903128915"),
  //   Contact("Adash Kv", "+998911334169"),
  //   Contact("Sanjar", "+998946941428"),
  //   Contact("Fayoz", "+998930000342"),
  //   Contact("Ravshan", "+998996062841"),
  //   Contact("Sardor", "+998907997720"),
  //   Contact("Donyor", "+998903128915"),
  //   Contact("Adash Kv", "+998911334169"),
  // ];

  Future<void> _makeCall(String number) async {
    await launch("tel:$number");
  }


  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    Iterable<Contact> contact = await ContactsService.getContacts();
    setState(() {
      _contacts = contact.where((element) => element.phones!.isNotEmpty);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Contacts"),
        ),
        body: ListView(
          children: [
            SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(_contacts.length, (index) => horizontal(index)),
            ),
          ),

            for(var i=0;i<_contacts.length;i++) vertical(i),

            // Expanded(
            //   child: ListView.builder(
            //     //shrinkWrap: true,
            //     itemCount: contacts.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         leading: CircleAvatar(
            //           backgroundColor: Colors.blue,
            //           child: Text(contacts[index].name[0]),
            //         ),
            //         title: Text(contacts[index].name),
            //         subtitle: Text(contacts[index].number),
            //         trailing: IconButton(
            //           onPressed: () {
            //             _makeCall(contacts[index].number);
            //           },
            //           icon: Icon(Icons.phone),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ));
  }


  Widget horizontal(int index) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(100, 80),
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(18), // <-- Radius
          ),
        ),
        onPressed: () {
          _makeCall(_contacts.elementAt(index).phones!.first.value.toString());
        },
        child: Text(_contacts.elementAt(index).displayName.toString()),
      ),
    );
  }

  Widget vertical(int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(_contacts.elementAt(index).initials()),
      ),
      title: Text(_contacts.elementAt(index).displayName.toString()),
      subtitle: Text(_contacts.elementAt(index).phones!.first.value.toString()),
      trailing: IconButton(
        onPressed: () {
          _makeCall(_contacts.elementAt(index).phones!.first.value.toString());
        },
        icon: Icon(Icons.phone),
      ),
    );
  }

}

// class Contact {
//   String name, number;
//   Contact(this.name, this.number);
// }




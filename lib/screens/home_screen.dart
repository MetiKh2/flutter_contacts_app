import 'dart:ffi';

import 'package:contacts/screens/add_edit_screen.dart';
import 'package:contacts/utils/network.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Network.checkInternet(context);
    Future.delayed(Duration(seconds: 1)).then((value) {
      if (Network.isConnected) {
        Network.getData().then((value) async {
          await Future.delayed(const Duration(seconds: 3));
          setState(() {});
        });
      } else {
        Network.showInternetError(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        onPressed: () {
          AddEditScreen.id = 0;
          AddEditScreen.nameController.text = '';
          AddEditScreen.phoneController.text = '';
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddEditScreen()))
              .then((value) async {
            Network.checkInternet(context);
            Future.delayed(Duration(seconds: 1)).then((value) {
              if (Network.isConnected) {
                Network.getData().then((value) async {
                  await Future.delayed(const Duration(seconds: 3));
                  setState(() {});
                });
              } else {
                Network.showInternetError(context);
              }
            });
          });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: const Text(
          'دفترچه تلفن آنلاین',
          style: TextStyle(fontSize: 16),
        ),
        leading: const Icon(Icons.import_contacts_sharp),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Network.checkInternet(context);
                Future.delayed(Duration(seconds: 1)).then((value) {
                  if (Network.isConnected) {
                    Network.getData().then((value) async {
                      await Future.delayed(const Duration(seconds: 3));
                      setState(() {});
                    });
                  } else {
                    Network.showInternetError(context);
                  }
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: Network.contacts.length,
          itemBuilder: (context, index) {
            return ListTile(
              onLongPress: () {
                Network.deleteData(id: Network.contacts[index].id);
                Future.delayed(Duration(seconds: 3));
                setState(() {});
              },
              leading: CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  AddEditScreen.id = Network.contacts[index].id;
                  AddEditScreen.nameController.text =
                      Network.contacts[index].fullName.toString();
                  AddEditScreen.phoneController.text =
                      Network.contacts[index].phone.toString();
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddEditScreen()))
                      .then((value) => Network.getData().then((value) async {
                            await Future.delayed(const Duration(seconds: 3));
                            setState(() {});
                          }));
                },
                icon: Icon(Icons.edit),
              ),
              title: Text(Network.contacts[index].fullName.toString()),
              subtitle: Text(Network.contacts[index].phone.toString()),
            );
          },
        ),
      ),
    );
  }
}

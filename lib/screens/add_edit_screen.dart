import 'package:contacts/utils/network.dart';
import 'package:contacts/widgets/my_button_widget.dart';
import 'package:contacts/widgets/my_textfield_widget.dart';
import 'package:flutter/material.dart';

class AddEditScreen extends StatefulWidget {
  static TextEditingController nameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static int? id = 0;
  AddEditScreen({super.key});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.redAccent,
          title: Text(
            AddEditScreen.id! > 0 ? 'ویرایش مخاطب' : ' مخاطب جدید',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              MyTextField(
                  errorText: 'نام را وارد کنید',
                  controller: AddEditScreen.nameController,
                  hintText: 'نام',
                  type: TextInputType.name),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                  errorText: 'شماره را وارد کنید',
                  controller: AddEditScreen.phoneController,
                  hintText: 'شماره',
                  type: TextInputType.phone),
              ButtonWidget(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Network.checkInternet(context);
                      Future.delayed(Duration(seconds: 1)).then((value) {
                        if (Network.isConnected) {
                          if (AddEditScreen.id! > 0) {
                            Network.putData(
                                id: AddEditScreen.id!,
                                phone: AddEditScreen.phoneController.text,
                                fullName: AddEditScreen.nameController.text);
                          } else {
                            Network.postData(
                                phone: AddEditScreen.phoneController.text,
                                fullName: AddEditScreen.nameController.text);
                          }
                          Navigator.pop(context);
                        } else {
                          Network.showInternetError(context);
                        }
                      });
                    }
                  },
                  text: AddEditScreen.id! > 0 ? 'ویرایش کردن' : 'اضافه کردن')
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cheking/main.dart';
import 'package:cheking/model/bank_model/bank_hive.dart';
import 'package:cheking/model/use_model/use_hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class SelectValuePage extends StatefulWidget {
  final bool addNewType;

  const SelectValuePage({super.key, required this.addNewType});

  @override
  State<SelectValuePage> createState() => _SelectValuePageState();
}

class _SelectValuePageState extends State<SelectValuePage> {
  late Box<UseHive> useBox;
  late Box<BankHive> bankBox;
  final formState = GlobalKey<FormState>();
  final useController = TextEditingController();
  final bankController = TextEditingController();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.addNewType ? 'Add Use' : 'Add Bank'),
          content: SingleChildScrollView(
            child: Form(
              key: formState,
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    controller:
                        widget.addNewType ? useController : bankController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return widget.addNewType ? 'Add Use' : 'Add Bank';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: widget.addNewType ? 'Add Use' : 'Add Bank',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100))),
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                useController.clear();
                bankController.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add',
                  style: TextStyle(color: Colors.greenAccent)),
              onPressed: () {
                if (formState.currentState!.validate()) {
                  widget.addNewType
                      ? useBox.add(UseHive(useController.text))
                      : bankBox.add(BankHive(bankController.text));
                  useController.clear();
                  bankController.clear();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    useBox = Hive.box('use');
    bankBox = Hive.box('bank');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.addNewType ? "Select Use" : "Select Bank",
            style: TextStyle(fontSize: 15.sp),
          ),
          centerTitle: true,
          elevation: 10,
          toolbarHeight: 70,
          backgroundColor: const Color(0xffe4e2ac)),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8).r,
            child: widget.addNewType
                ? ValueListenableBuilder(
                    valueListenable: useBox.listenable(),
                    builder: (context, value, child) {
                      return value.isEmpty
                          ? Center(
                              child: Text(
                                "Nothing added here",
                                style: TextStyle(fontSize: 15.sp),
                              ),
                            )
                          : ListView.builder(
                              itemCount: value.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12).r,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(color: Colors.black)),
                                  child: ListTile(
                                    leading: const Icon(Icons.check_rounded),
                                    title:
                                        Text(value.getAt(index)?.addUse ?? " "),
                                  ),
                                );
                              },
                            );
                    },
                  )
                : ValueListenableBuilder(
                    valueListenable: bankBox.listenable(),
                    builder: (context, value, child) {
                      return value.isEmpty
                          ? Center(
                              child: Text(
                                "Nothing added here",
                                style: TextStyle(fontSize: 15.sp),
                              ),
                            )
                          : ListView.builder(
                              itemCount: value.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12).r,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(color: Colors.black)),
                                  child: ListTile(
                                    leading:const Icon(Icons.monetization_on ) ,
                                    title: Text(
                                        value.getAt(index)?.addBank ?? " "),
                                  ),
                                );
                              },
                            );
                    },
                  )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMyDialog();
        },
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none),
        backgroundColor: Colors.greenAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

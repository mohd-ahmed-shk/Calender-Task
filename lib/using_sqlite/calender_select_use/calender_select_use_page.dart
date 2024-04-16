import 'package:cheking/main.dart';
import 'package:cheking/model/bank_model/bank_hive.dart';
import 'package:cheking/model/use_model/use_hive.dart';
import 'package:cheking/using_sqlite/helper/bank_helper.dart';
import 'package:cheking/using_sqlite/helper/use_helper.dart';
import 'package:cheking/using_sqlite/model/bank_model/bank_model.dart';
import 'package:cheking/using_sqlite/model/use_model/use_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class CalenderSelectUsePage extends StatefulWidget {
  final bool addNewType;

  const CalenderSelectUsePage({super.key, required this.addNewType});

  @override
  State<CalenderSelectUsePage> createState() => _CalenderSelectUsePageState();
}

class _CalenderSelectUsePageState extends State<CalenderSelectUsePage> {
  final formState = GlobalKey<FormState>();
  final useController = TextEditingController();
  final bankController = TextEditingController();

  void addUse(String use) async {
    await UseHelper.addDateUse(UseModel(null, use));
  }

  void addBank(String bank) async {
    await BankHelper.addDateBank(BankModel(null, bank));
  }

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
                  setState(() {

                  });
                  widget.addNewType
                      ? addUse(useController.text)
                      : addBank(bankController.text);
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
                ? FutureBuilder(
                    future: UseHelper.getUseAll(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else {
                        if (snapshot.connectionState ==
                                ConnectionState.active ||
                            snapshot.connectionState == ConnectionState.done) {
                          if(snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12).r,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(color: Colors.black)),
                                  child: ListTile(
                                    leading: const Icon(Icons.check_rounded),
                                    title:
                                    Text(snapshot.data?[index].use ?? " "),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(child: Text("No Data"),);
                          }
                        } else {
                          return Center(child: Text(snapshot.error.toString()),);
                        }
                      }
                    },
                  )
                : FutureBuilder(
              future: BankHelper.getBankAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else {
                  if (snapshot.connectionState ==
                      ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if(snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12).r,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.black)),
                            child: ListTile(
                              leading: const Icon(Icons.check_rounded),
                              title:
                              Text(snapshot.data?[index].bank ?? " "),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text("No Data"),);
                    }
                  } else {
                    return Center(child: Text(snapshot.error.toString()),);
                  }
                }
              },
            )
        ),
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

import 'package:cheking/model/bank_model/bank_hive.dart';
import 'package:cheking/model/use_model/use_hive.dart';
import 'package:cheking/ui/home/home_page.dart';
import 'package:cheking/ui/select_value/select_value_page.dart';
import 'package:cheking/using_sqlite/calender_select_use/calender_select_use_page.dart';
import 'package:cheking/using_sqlite/helper/bank_helper.dart';
import 'package:cheking/using_sqlite/helper/calender_helper.dart';
import 'package:cheking/using_sqlite/helper/use_helper.dart';
import 'package:cheking/using_sqlite/model/bank_model/bank_model.dart';
import 'package:cheking/using_sqlite/model/calender_model/calender_model.dart';
import 'package:cheking/using_sqlite/model/use_model/use_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../model/meeting.dart';
import '../calender_home/calender_home_page.dart';

class CalenderAddPage extends StatefulWidget {
  final List<CalenderModel> val;
  String? selectedUse;
  final CalendarTapDetails calendarTapDetails;

  CalenderAddPage(
      {super.key,
      required this.val,
      required this.calendarTapDetails,
      required this.selectedUse});

  @override
  State<CalenderAddPage> createState() => _CalenderAddPageState();
}

class _CalenderAddPageState extends State<CalenderAddPage> {
  final amountController = TextEditingController();
  final titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<UseModel> dropDownUse = [];

  void getDropDownUse() async {
    dropDownUse = await UseHelper.getUseAll();
    setState(() {});
  }

  List<CalenderModel> list = [];
  TextStyle textStyle = TextStyle(fontSize: 20.sp, color: Colors.black);

  @override
  void initState() {
    super.initState();
    getDropDownUse();

    if (widget.selectedUse == "All") {
      list = widget.val.where((element) {
        if (DateTime.parse(element.date!).year ==
                widget.calendarTapDetails.date?.year &&
            DateTime.parse(element.date!).month ==
                widget.calendarTapDetails.date?.month &&
            DateTime.parse(element.date!).day ==
                widget.calendarTapDetails.date?.day) {
          return true;
        }
        return false;
      }).toList();
    } else {
      list = widget.val.where((element) {
        if (DateTime.parse(element.date!).year ==
                widget.calendarTapDetails.date?.year &&
            DateTime.parse(element.date!).month ==
                widget.calendarTapDetails.date?.month &&
            DateTime.parse(element.date!).day ==
                widget.calendarTapDetails.date?.day &&
            element.use == widget.selectedUse) {
          return true;
        }
        return false;
      }).toList();
    }
  }

  void _repeatAmountForYear(CalenderModel meeting) async {
    for (int month = widget.calendarTapDetails.date?.month ?? 4;
        month <= 12;
        month++) {
      DateTime date = DateTime(DateTime.parse(meeting.date!).year, month,
          DateTime.parse(meeting.date!).day);
      var data = CalenderModel(
          null,
          amountController.text,
          _selectedItem1!,
          widget.calendarTapDetails.date!.toIso8601String(),
          _selectedItem!,
          titleController.text,
          _selectedItem2!);

      await CalenderHelper.addDate(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.calendarTapDetails.date.toString().split(' ')[0]),
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: const Color(0xffe4e2ac),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20).r,
            child: SizedBox(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: DropdownButtonFormField<String>(
                    value: widget.selectedUse,
                    onChanged: (String? value) {
                      setState(() {
                        widget.selectedUse = value!;
                        if (widget.selectedUse == "All") {
                          list = widget.val.where((element) {
                            if (DateTime.parse(element.date!).year ==
                                    widget.calendarTapDetails.date?.year &&
                                DateTime.parse(element.date!).month ==
                                    widget.calendarTapDetails.date?.month &&
                                DateTime.parse(element.date!).day ==
                                    widget.calendarTapDetails.date?.day) {
                              return true;
                            }
                            return false;
                          }).toList();
                        } else {
                          list = widget.val.where((element) {
                            if (DateTime.parse(element.date!).year ==
                                    widget.calendarTapDetails.date?.year &&
                                DateTime.parse(element.date!).month ==
                                    widget.calendarTapDetails.date?.month &&
                                DateTime.parse(element.date!).day ==
                                    widget.calendarTapDetails.date?.day &&
                                element.use == widget.selectedUse) {
                              return true;
                            }
                            return false;
                          }).toList();
                        }
                      });
                    },
                    items: dropDownUse
                        .map<DropdownMenuItem<String>>((UseModel value) {
                      return DropdownMenuItem<String>(
                        value: value.use,
                        child: Text(value.use ?? " "),
                      );
                    }).toList(),
                    isDense: true,
                    padding: EdgeInsets.zero,
                    decoration: const InputDecoration(
                        hintText: 'Select Use', border: InputBorder.none)),
              ),
            ),
          )
        ],
      ),
      body: list.isEmpty
          ? const Center(
              child: Text("Empty"),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10).r,
                    padding: const EdgeInsets.all(10).r,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 0,
                      title: Text(
                        list[index].title ?? " ",
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bank : ${list[index].bank}',
                              style: const TextStyle(color: Colors.grey)),
                          Text(
                            'Use : ${list[index].use}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text('Frequency : ${list[index].frequency}',
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      trailing: Container(
                          padding: const EdgeInsets.all(10).r,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.greenAccent),
                          child: Text("₹ ${list[index].amount}",
                              style: TextStyle(fontSize: 15.sp))),
                    ),
                  );
                },
              )),
      floatingActionButton: buildBuilder(),
    );
  }

  String? _selectedItem;
  String? _selectedItem1;
  String? _selectedItem2;

  Widget buildBuilder() {
    return Builder(
      builder: (context) {
        return FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        height: 500.h,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Add your Expense',
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                  15.verticalSpace,
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Title';
                                      }
                                    },
                                    controller: titleController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        hintText: 'Enter the title'),
                                  ),
                                  10.verticalSpace,
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Amount';
                                      }
                                    },
                                    controller: amountController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        hintText: 'Enter the amount'),
                                  ),
                                  10.verticalSpace,
                                  DropdownButtonFormField<String>(
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Select Frequency';
                                      }
                                    },
                                    value: _selectedItem,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedItem = value;
                                      });
                                    },
                                    items: <String>['Today', 'Monthly']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    decoration: InputDecoration(
                                      hintText: 'Select Frequency',
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                  ),
                                  10.verticalSpace,
                                  Row(
                                    children: [
                                      Expanded(
                                          child: FutureBuilder(
                                        future: UseHelper.getUseAll(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: CircularProgressIndicator
                                                  .adaptive(),
                                            );
                                          } else {
                                            return DropdownButtonFormField<
                                                String>(
                                              validator: (value) {
                                                if (value == null ||
                                                    value == "All") {
                                                  return 'Select Use';
                                                }
                                              },
                                              value: _selectedItem1,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _selectedItem1 = value;
                                                });
                                              },
                                              items: snapshot.data?.map<
                                                      DropdownMenuItem<String>>(
                                                  (UseModel value) {
                                                return DropdownMenuItem<String>(
                                                  value: value.use,
                                                  child: Text(value.use ?? ""),
                                                );
                                              }).toList(),
                                              decoration: InputDecoration(
                                                hintText: 'Select Use',
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                            );
                                          }
                                        },
                                      )),
                                      10.horizontalSpace,
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CalenderSelectUsePage(
                                                    addNewType: true,
                                                  ),
                                                ));
                                          },
                                          child: Text(
                                            "Add New +",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                color: Colors.greenAccent),
                                          ))
                                    ],
                                  ),
                                  10.verticalSpace,
                                  Row(
                                    children: [
                                      Expanded(
                                          child: FutureBuilder(
                                        future: BankHelper.getBankAll(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: CircularProgressIndicator
                                                  .adaptive(),
                                            );
                                          } else {
                                            return DropdownButtonFormField<
                                                String>(
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'Select Bank';
                                                }
                                              },
                                              value: _selectedItem2,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _selectedItem2 = value;
                                                });
                                              },
                                              items: snapshot.data?.map<
                                                      DropdownMenuItem<String>>(
                                                  (BankModel value) {
                                                return DropdownMenuItem<String>(
                                                  value: value.bank,
                                                  child: Text(value.bank ?? ""),
                                                );
                                              }).toList(),
                                              decoration: InputDecoration(
                                                hintText: 'Select Bank',
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                            );
                                          }
                                        },
                                      )),
                                      10.horizontalSpace,
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CalenderSelectUsePage(
                                                    addNewType: false,
                                                  ),
                                                ));
                                          },
                                          child: Text(
                                            "Add New +",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                color: Colors.greenAccent),
                                          ))
                                    ],
                                  ),
                                  15.verticalSpace,
                                  SizedBox(
                                      height: 44.h,
                                      width: double.maxFinite,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.grey.shade300,
                                                  elevation: 0),
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20.sp),
                                              ),
                                            ),
                                          ),
                                          20.horizontalSpace,
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  var data = CalenderModel(
                                                      null,
                                                      amountController.text,
                                                      _selectedItem1!,
                                                      widget.calendarTapDetails
                                                          .date!
                                                          .toIso8601String(),
                                                      _selectedItem!,
                                                      titleController.text,
                                                      _selectedItem2!);

                                                  await CalenderHelper.addDate(
                                                      data);

                                                  // if (_selectedItem ==
                                                  //     "Monthly") {
                                                  //   _repeatAmountForYear(
                                                  //       meeting);
                                                  // } else {
                                                  //   meetingBox.add(meeting);
                                                  // }

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  "Data Added")));
                                                  await Navigator
                                                      .pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const CalenderHomePage(),
                                                          ),
                                                          (route) => false);
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xffe4e2ac),
                                                  elevation: 0),
                                              child: Text(
                                                "Add",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.sp),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
          elevation: 0,
          backgroundColor: const Color(0xffe4e2ac),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none),
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        );
      },
    );
  }

  DropdownSearch<String> buildDropdownSearch(StateSetter setState) {
    return DropdownSearch<String>(
      validator: (value) {
        if (value == null) {
          return 'Select Frequency';
        }
      },
      itemAsString: (item) => item,
      onChanged: (String? value) {
        setState(() {
          _selectedItem = value;
        });
      },
      items: <String>['Today', 'Monthly'],
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: 'Select Frequency',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(50)),
        ),
      ),
    );
  }
}

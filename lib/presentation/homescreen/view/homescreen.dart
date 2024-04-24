import 'package:apiexam/globalwidget/textfield.dart';
import 'package:apiexam/presentation/homescreen/controller/homescreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(MaterialApp(home: Homescreen()));
// }

class Homescreen extends StatefulWidget {
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  var name_ctrl = TextEditingController();

  var role_ctrl = TextEditingController();

  @override
  void initState() {
    Provider.of<HomescreenController>(context, listen: false).fetchEmpList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
        shadowColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red.shade100,
          foregroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () {
            bottomSheet(context);
          }),
      body: Consumer<HomescreenController>(
          builder: (context, controller, child) => controller.isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: controller.employeeModel.data?.employee?.length,
                  itemBuilder: (BuildContext, int index) {
                    int? id =
                        controller.employeeModel.data?.employee?[index].id;
                    return Card(
                        shadowColor: Colors.black,
                        elevation: 10,
                        surfaceTintColor: Colors.red,
                        child: ListTile(
                            title: Text(controller.employeeModel.data
                                    ?.employee?[index].name ??
                                ""),
                            subtitle: Text(controller.employeeModel.data
                                    ?.employee?[index].role ??
                                ""),
                            trailing: Wrap(children: [
                              IconButton(
                                  onPressed: () {
                                    updatebottomSheet(context, id);
                                    Provider.of<HomescreenController>(context,
                                            listen: false)
                                        .updateEmployee(
                                            name: name_ctrl.text,
                                            role: role_ctrl.text,
                                            id: id);
                                  },
                                  icon: Icon(Icons.edit)),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      Provider.of<HomescreenController>(context,
                                              listen: false)
                                          .deleteEmployee(id);
                                    });
                                  },
                                  icon: Icon(Icons.delete)),
                            ])));
                  })),
    );
  }

  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.red.shade100,
        showDragHandle: true,
        enableDrag: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Fieldd(
                      labeltext: "Name",
                      prefixicon: Icon(Icons.person),
                      controller: name_ctrl,
                    ),
                    SizedBox(height: 5),
                    Fieldd(
                      labeltext: "Role",
                      prefixicon: Icon(Icons.work),
                      controller: role_ctrl,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Provider.of<HomescreenController>(context,
                                listen: false)
                            .addEmployee(
                                name: name_ctrl.text, role: role_ctrl.text);
                        Navigator.pop(context);

                        name_ctrl.clear();
                        role_ctrl.clear();
                        setState(() {
                          Provider.of<HomescreenController>(context,
                                  listen: false)
                              .fetchEmpList();
                        });
                      },
                      color: Colors.grey,
                      child: Text("Save"),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void updatebottomSheet(BuildContext context, int? id) {
    showModalBottomSheet(
        backgroundColor: Colors.red.shade100,
        showDragHandle: true,
        enableDrag: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Fieldd(
                      labeltext: "Name",
                      prefixicon: Icon(Icons.person),
                      controller: name_ctrl,
                    ),
                    SizedBox(height: 5),
                    Fieldd(
                      labeltext: "Role",
                      prefixicon: Icon(Icons.work),
                      controller: role_ctrl,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Provider.of<HomescreenController>(context,
                                listen: false)
                            .updateEmployee(
                                name: name_ctrl.text,
                                role: role_ctrl.text,
                                id: id);
                        Navigator.pop(context);

                        name_ctrl.clear();
                        role_ctrl.clear();
                        setState(() {
                          Provider.of<HomescreenController>(context,
                                  listen: false)
                              .fetchEmpList();
                        });
                      },
                      color: Colors.grey,
                      child: Text("Save"),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

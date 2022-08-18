// import 'package:flutter/material.dart';
// import 'package:flutter_sqlite/widgets/appbar_widget.dart';

// class FormDeveloper extends StatefulWidget {

// //  int id = null;
// //  final String nameChange;
//   final developerForm = GlobalKey<FormState>();
//   FormDeveloper({Key? key}) : super(key: key);
//   @override
//   _FormDeveloperState createState() => _FormDeveloperState();
// }

// class _FormDeveloperState extends State<FormDeveloper> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: MyAppBar(
//         title: widget.id == null ? "Create Developer" : widget.nameChange,
//         actionsAppBar: Container(),
//       ),
//       body: Center(
//         child: Container(
//           width: size.width * 0.95,
//           padding: EdgeInsets.all(5),
//           child: Form(
//               key: widget.developerForm,
//               child: ListView(
//                 children: [
//                   SizedBox(
//                     height: 5,
//                   ),
//                   InputText(
//                     name: name,
//                     validator: (v) {
//                       if (v.isEmpty) {
//                         return "Field can not be empty";
//                       }
//                       return null;
//                     },
//                     onChanged: (value) {
//                       setState(() {
//                         name = value;
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   DropDownWidget(
                    
//                     hint: choices == null
//                         ? Padding(
//                             padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                             child: Text(
//                               'Select option',
//                               style: TextStyle(
//                                   fontSize: 18, color: CustomColors.textColor),
//                             ),
//                           )
//                         : Padding(
//                             padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                             child: Text(
//                               choices,
//                               style: TextStyle(color: CustomColors.textColor),
//                             ),
//                           ), 
//                     dropdownItens: devLevel.map(
//                       (val) {
//                         return DropdownMenuItem<String>(
//                           value: val["name"],
//                           child:
//                               Container(width: 100, child: Text(val["name"])),
//                         );
//                       },
//                     ).toList(),
                    
//                     onChanged: (val) {
//                       setState(
//                         () {
//                           choices = val;
//                         },
//                       );
//                     },
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   CheckBoxWidget(
//                     checkedIten: Checkbox(
//                       value: isGraduated,
//                       activeColor: CustomColors.theme,
//                       onChanged: (bool valor) {
//                         setState(() {
//                           isGraduated = valor;
//                         });
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 60,
//                   ),
//                   ElevatedButton(
//                       style:
//                           ElevatedButton.styleFrom(primary: CustomColors.theme),
//                       onPressed: submitData,
//                       child: widget.id == null
//                           ? Text("Create Developer")
//                           : Text("Update Developer")),
//                 ],
//               )),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:vanillia/constants/themes.dart';
// import 'package:vanillia/localization/language_constants.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class ChooseImage extends StatefulWidget {
//   @override
//   _ChooseImageState createState() => _ChooseImageState();
// }

// class _ChooseImageState extends State<ChooseImage> {
//   bool isEidt = true;
//   var _image;
//   Future getImage() async {
//     // ignore: deprecated_member_use
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _image = image;
//     });
//   }

//   Future uploadImage(BuildContext context) async {
//     String flileName = basename(_image.path);
//     StorageReference storageRefernece =
//         FirebaseStorage.instance.ref().child(flileName);
//     StorageUploadTask uploadTask = storageRefernece.putFile(_image);
//     StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//     setState(() {
//       Scaffold.of(context).showSnackBar(SnackBar(
//         content: Text('تم الحفظ'),
//       ));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           CircleAvatar(
//             radius: 55,
//             backgroundColor: Colors.white,
//             child: ClipOval(
//               child: SizedBox(
//                 height: 105,
//                 width: 105,
//                 child: (_image != null)
//                     ? Image.file(_image, fit: BoxFit.fill)
//                     : Image.network(
//                         'https://www.pinclipart.com/picdir/big/91-919500_individuals-user-vector-icon-png-clipart.png',
//                         fit: BoxFit.fill,
//                       ),
//               ),
//             ),
//           ),
//           Row(
//             children: [
//               Icon(Icons.camera),
//               FlatButton(
//                 child: Text(
//                   (isEidt)
//                       ? getTranslated(context, 'edit')
//                       : getTranslated(context, 'save'),
//                   style: AppTheme.heading,
//                 ),
//                 onPressed: () {
//                   if (isEidt == true) {
//                     setState(() {
//                       isEidt = !isEidt;
//                     });
//                     // getImage();
//                   }
//                   if (isEidt == false) {
//                     setState(
//                       () {
//                         isEidt = !isEidt;
//                       },
//                     );
//                     // uploadImage(context);
//                   }
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

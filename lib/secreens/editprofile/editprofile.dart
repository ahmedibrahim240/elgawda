import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/userData.dart';
import 'package:elgawda/services/UserData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool obscurePassword = true;
  String mobile;
  String email;
  String name;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Users>(
        stream: DatabaseServices(context: context, userToken: User.userToken)
            .userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Users userData = snapshot.data;
            return SafeArea(
              child: ListView(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                children: [
                  Center(
                    child: Text(
                      getTranslated(context, 'edit_profile'),
                      style: AppTheme.headingColorBlue.copyWith(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 10),
                  UserPorfileImage(
                    userimgUrl: userData.image,
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTranslated(context, 'name'),
                          style:
                              AppTheme.headingColorBlue.copyWith(fontSize: 15),
                        ),
                        TextFormField(
                          initialValue: userData.name,
                          onChanged: (val) {
                            setState(() {
                              name = val;
                            });
                          },
                          decoration:
                              textFormInpuofEidtProfile(icon: Icons.edit),
                        ),
                        SizedBox(height: 10),
                        Text(
                          getTranslated(context, 'phone_numer'),
                          style:
                              AppTheme.headingColorBlue.copyWith(fontSize: 15),
                        ),
                        TextFormField(
                          initialValue: userData.moblie,
                          keyboardType: TextInputType.phone,
                          onChanged: (val) {
                            setState(() {
                              mobile = val;
                            });
                          },
                          decoration: textFormInpuofEidtProfile(),
                        ),
                        SizedBox(height: 10),
                        Text(
                          getTranslated(context, 'email'),
                          style:
                              AppTheme.headingColorBlue.copyWith(fontSize: 15),
                        ),
                        TextFormField(
                          initialValue: userData.email,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          decoration:
                              textFormInpuofEidtProfile(icon: Icons.edit),
                        ),
                        SizedBox(height: 10),
                        Text(
                          getTranslated(context, 'password'),
                          style:
                              AppTheme.headingColorBlue.copyWith(fontSize: 15),
                        ),
                        TextFormField(
                          initialValue: User.userPassword,
                          obscureText: obscurePassword,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          decoration: textFormInputDecorationForPassword(
                            Icons.visibility_off,
                            'password',
                            () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            obscurePassword,
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: CustomButton(
                            onPress: () {
                              setState(() {
                                loading = !loading;
                              });
                              DatabaseServices(
                                      userToken: User.userToken,
                                      context: context)
                                  .upDateUserData(
                                email: (email != null)
                                    ? email
                                    : (userData.email ==
                                            getTranslated(context, 'addEmail'))
                                        ? ''
                                        : userData.email,
                                name: (name != null) ? name : userData.name,
                                mobile: (mobile != null)
                                    ? mobile
                                    : (userData.moblie ==
                                            getTranslated(context, 'addPhone'))
                                        ? ''
                                        : userData.moblie,
                                password: (password != null) ? password : '',
                                images: (UserPorfileImage.image) ?? null,
                                context: context,
                              );
                            },
                            text: (loading)
                                ? getTranslated(context, 'saving')
                                : getTranslated(context, 'save'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

class UserPorfileImage extends StatefulWidget {
  static File image;
  const UserPorfileImage({
    Key key,
    // @required this.onTap,
    this.userimgUrl,
  }) : super(key: key);

  // final Function onTap;
  final String userimgUrl;

  @override
  _UserPorfileImageState createState() => _UserPorfileImageState();
}

class _UserPorfileImageState extends State<UserPorfileImage> {
  final picker = ImagePicker();
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showPickOptionsDialog(context);
      },
      child: Center(
        child: Stack(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: customColor,
                  width: 1,
                ),
              ),
              padding: EdgeInsets.all(2),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipOval(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: (_imageFile != null)
                        ? Image.file(
                            _imageFile,
                            fit: BoxFit.cover,
                          )
                        : (widget.userimgUrl == '' && widget.userimgUrl == null)
                            ? Image(
                                fit: BoxFit.cover,
                                image: AssetImage('lib/images/man.png'),
                              )
                            : customCachedNetworkImage(
                                context: context,
                                url: widget.userimgUrl,
                              ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadPicker(ImageSource source, BuildContext context) async {
    // ignore: deprecated_member_use
    File picked = await ImagePicker.pickImage(source: source);
    if (picked != null) {
      _cropImage(picked, context);
    }
    Navigator.of(context).pop();
  }

  _cropImage(File picked, BuildContext context) async {
    try {
      File cropped = await ImageCropper.cropImage(
        androidUiSettings: AndroidUiSettings(
          statusBarColor: Colors.red,
          toolbarColor: Colors.red,
          toolbarTitle: "Crop Image",
          toolbarWidgetColor: Colors.white,
        ),
        sourcePath: picked.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio16x9,
          CropAspectRatioPreset.ratio4x3,
        ],
        maxWidth: 800,
      );
      if (cropped != null) {
        setState(() {
          _imageFile = cropped;
          UserPorfileImage.image = _imageFile;
        });
      }
    } catch (e) {
      print('piker error:' + e.toString());
    }
  }

  void _showPickOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(getTranslated(context, 'Gallery')),
              onTap: () {
                _loadPicker(ImageSource.gallery, context);
              },
            ),
            ListTile(
              title: Text(getTranslated(context, 'takepictuer')),
              onTap: () {
                _loadPicker(ImageSource.camera, context);
              },
            )
          ],
        ),
      ),
    );
  }
}

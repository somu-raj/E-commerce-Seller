import 'dart:async';
import 'package:eshopmultivendor/Helper/ApiBaseHelper.dart';
import 'package:eshopmultivendor/Helper/AppBtn.dart';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Helper/String.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'change_password_page.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateProfile();
}

String? lat, long;

class StateProfile extends State<Profile> with TickerProviderStateMixin {
//==============================================================================
//========================== Variable Dectlaration =============================

  String? name,
      email,
      mobile,
      address,
      image,
      curPass,
      newPass,
      confPass,
      loaction,
      accNo,
      storename,
      storeurl,
      storeDesc,
      accname,
      bankname,
      bankcode,
      latitutute,
      longitude,
      taxname,
      taxnumber,
      pannumber,
      status,
      storelogo;

  bool _isLoading = false;
  GlobalKey<FormState> sellernameKey = GlobalKey<FormState>();
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> addressKey = GlobalKey<FormState>();
  GlobalKey<FormState> storenameKey = GlobalKey<FormState>();
  GlobalKey<FormState> storeurlKey = GlobalKey<FormState>();
  GlobalKey<FormState> storeDescKey = GlobalKey<FormState>();
  GlobalKey<FormState> accnameKey = GlobalKey<FormState>();
  GlobalKey<FormState> accnumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> bankcodeKey = GlobalKey<FormState>();
  GlobalKey<FormState> banknameKey = GlobalKey<FormState>();
  GlobalKey<FormState> latitututeKey = GlobalKey<FormState>();
  GlobalKey<FormState> longituteKey = GlobalKey<FormState>();
  GlobalKey<FormState> taxnameKey = GlobalKey<FormState>();
  GlobalKey<FormState> taxnumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> pannumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController? nameC,
      emailC,
      mobileC,
      addressC,
      storenameC,
      storeurlC,
      storeDescC,
      accnameC,
      accnumberC,
      bankcodeC,
      banknameC,
      latitututeC,
      longituteC,
      taxnameC,
      taxnumberC,
      pannumberC,
      curPassC,
      newPassC,
      confPassC;

  bool isSelected = false, isArea = true;
  bool _isNetworkAvail = true;
  bool _showCurPassword = false, _showPassword = false, _showCmPassword = false;
  Animation? buttonSqueezeanimation;
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  AnimationController? buttonController;

  var curPassController = TextEditingController();
  var newPassController = TextEditingController();
  var againPassController = TextEditingController();

//==============================================================================
//============================= Init method ====================================

  @override
  void initState() {
    super.initState();

    mobileC = new TextEditingController();
    nameC = new TextEditingController();
    emailC = new TextEditingController();
    addressC = new TextEditingController();
    storenameC = new TextEditingController();
    storeurlC = new TextEditingController();
    storeDescC = new TextEditingController();
    accnameC = new TextEditingController();
    accnumberC = new TextEditingController();
    bankcodeC = new TextEditingController();
    banknameC = new TextEditingController();
    latitututeC = new TextEditingController();
    longituteC = new TextEditingController();
    taxnameC = new TextEditingController();
    pannumberC = new TextEditingController();
    taxnumberC = new TextEditingController();
    getUserDetails();

    buttonController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = new Tween(
      begin: width * 0.7,
      end: 50.0,
    ).animate(
      new CurvedAnimation(
        parent: buttonController!,
        curve: new Interval(
          0.0,
          0.150,
        ),
      ),
    );
  }
//==============================================================================
//============================= dispose method =================================

  @override
  void dispose() {
    buttonController!.dispose();
    mobileC?.dispose();
    nameC?.dispose();
    addressC!.dispose();
    emailC!.dispose();
    storenameC!.dispose();
    storeurlC!.dispose();
    storeDescC!.dispose();
    accnameC!.dispose();
    accnumberC!.dispose();
    bankcodeC!.dispose();
    banknameC!.dispose();
    latitututeC!.dispose();
    longituteC!.dispose();
    taxnameC!.dispose();
    pannumberC!.dispose();
    taxnumberC!.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

//==============================================================================
//================= User Details frome Shared Preferance =======================

  getUserDetails() async {
    CUR_USERID = await getPrefrence(Id);
    mobile = await getPrefrence(Mobile);
    name = await getPrefrence(Username);
    email = await getPrefrence(Email);
    address = await getPrefrence(Address);
    image = await getPrefrence(IMage);
    CUR_USERID = await getPrefrence(Id);
    mobile = await getPrefrence(Mobile);
    storename = await getPrefrence(Storename);
    storeurl = await getPrefrence(Storeurl);
    storeDesc = await getPrefrence(storeDescription);
    accNo = await getPrefrence(accountNumber);
    accname = await getPrefrence(accountName);
    bankcode = await getPrefrence(bankCode);
    bankname = await getPrefrence(bankName);
    latitutute = await getPrefrence(Latitude);
    longitude = await getPrefrence(Longitude);
    taxname = await getPrefrence(taxName);
    taxnumber = await getPrefrence(taxNumber);
    pannumber = await getPrefrence(panNumber);
    status = await getPrefrence(STATUS);
    storelogo = await getPrefrence(StoreLogo);
    mobileC!.text = mobile ?? "";
    nameC!.text = name ?? "";
    emailC!.text = email ?? "";
    addressC!.text = address ?? "";
    storenameC!.text = storename ?? "";
    storeurlC!.text = storeurl ?? "";
    storeDescC!.text = storeDesc ?? "";
    accnameC!.text = accname ?? "";
    accnumberC!.text = accNo ?? "";
    bankcodeC!.text = bankcode ?? "";
    banknameC!.text = bankname ?? "";
    latitututeC!.text = latitutute ?? "";
    longituteC!.text = longitude ?? "";
    taxnameC!.text = taxname ?? "";
    taxnumberC!.text = taxnumber ?? "";
    pannumberC!.text = pannumber ?? "";
    setState(() {});
  }

//==============================================================================
//===================== noInternet Widget ======================================

  Widget noInternet(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            noIntImage(),
            noIntText(context),
            noIntDec(context),
            AppBtn(
              title: getTranslated(context, "TRY_AGAIN_INT_LBL")!,
              btnAnim: buttonSqueezeanimation,
              btnCntrl: buttonController,
              onBtnSelected: () async {
                _playAnimation();

                Future.delayed(
                  Duration(seconds: 2),
                ).then(
                  (_) async {
                    _isNetworkAvail = await isNetworkAvailable();
                    if (_isNetworkAvail) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => super.widget,
                        ),
                      );
                    } else {
                      await buttonController!.reverse();
                      setState(
                        () {},
                      );
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

//==============================================================================
//======================= For Form validate And Submit =========================

  // bool validateAndSave() {
  //   final form = _formKey.currentState!;
  //   if (form.validate()) {
  //     form.save();
  //     return true;
  //   }
  //   return false;
  // }

  // void validateAndSubmit() async {
  //   if (validateAndSave()) {
  //     checkNetwork();
  //   }
  // }

//==============================================================================
//========================= Network awailabilitry ==============================

  Future<void> checkNetwork() async {
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
     await buttonController!.reverse();
      setUpdateUser();
    } else {
      Future.delayed(Duration(seconds: 2)).then(
        (_) async {
          await buttonController!.reverse();
          setState(
            () {
              _isNetworkAvail = false;
            },
          );
        },
      );
    }
  }

//==============================================================================
//========================= For Update Saller API  =============================

  Future<void> setUpdateUser() async {
    var parameter = {
      Id: CUR_USERID,
      Name: name ?? "",
      Mobile: mobile ?? "",
      Email: email ?? "",
      Address: address ?? "",
      Storename: storename ?? "",
      Storeurl: storeurl ?? "",
      storeDescription: storeDesc ?? "",
      accountNumber: accNo ?? "",
      accountName: accname ?? "",
      bankCode: bankcode ?? "",
      bankName: bankname ?? "",
      Latitude: latitutute ?? "",
      Longitude: longitude ?? "",
      taxName: taxname ?? "",
      taxNumber: taxnumber ?? "",
      panNumber: pannumber ?? "",
      STATUS: status ?? "1",
    };

    apiBaseHelper.postAPICall(updateUserApi, parameter).then(
      (getdata) async {
        bool error = getdata["error"];
        String? msg = getdata["message"];
        if (!error) {
          await buttonController!.reverse();
          setSnackbar(msg!);
        } else {
          await buttonController!.reverse();
          setSnackbar(msg!);
          setState(() {});
        }
      },
      onError: (error) {
        setSnackbar(error.toString());
      },
    );
  }

//==============================================================================
//========================== SanackBar code ====================================

  setSnackbar(String msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: primary,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

//==============================================================================
//========================== build Method ======================================

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: lightWhite,
      appBar: getAppBar(getTranslated(context, "EDIT_PROFILE_LBL")!, context),
      body: Stack(
        children: <Widget>[
          bodyPart(),
          showCircularProgress(_isLoading, primary)
        ],
      ),
    );
  }

//==============================================================================
//========================== build Method ======================================
  bodyPart() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: _isNetworkAvail
            ? Column(
                children: <Widget>[
                  getprofileImage(),
                  getFirstHeader(),
                  getSecondHeader(),
                  getThirdHeader(),
                  getFurthHeader(),
                  changePass(),
                  updateBtn(),
                ],
              )
            : noInternet(context),
      ),
    );
  }

//==============================================================================
//=========================== profile Image ====================================

  getprofileImage() {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
      child: CircleAvatar(
        radius: 50,
        backgroundColor: primary,
        child: LOGO != ''
            ? Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: primary)),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(LOGO),
                  radius: 100,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: primary)),
                child: Icon
                  (Icons.account_circle, size: 100)
        ),
      ),
    );
  }


  // getprofileImage(String profileImage, VoidCallback? onBtnSelected) {
  //   // var user = Provider.of<UserProvider>(context, listen: false);
  //   return Stack(
  //     children: <Widget>[
  //       Container(
  //         margin: EdgeInsetsDirectional.only(end: 20),
  //         height: 80,
  //         width: 80,
  //         decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             border: Border.all(
  //                 width: 1.0, color: Theme.of(context).colorScheme.primary)),
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(100.0),
  //           child: Consumer(builder: (context, userProvider, _)
  //           {
  //             return CUR_USERID != null
  //                 ? FutureBuilder(
  //                 // future: userDetails(),
  //                 builder: (BuildContext context, AsyncSnapshot snapshot) {
  //                   if (snapshot.hasData) {
  //                     var data = snapshot.data.date;
  //                     // user.setEmail("${data[0].email}");
  //                     // user.setName("${data[0].username}");
  //                     print("Profile Data ========================> ${data[0].proPic}");
  //                     return data[0].proPic != null
  //                         ? Image.network("assets/images/placeholder.png")
  //                         : Image.asset("assets/images/placeholder.png");
  //                   } else if (snapshot.hasError) {
  //                     return Icon(Icons.error_outline);
  //                   } else {
  //                     return CircularProgressIndicator();
  //                   }
  //                 })
  //                 : SizedBox(
  //                 height: 1,
  //             );
  //             // imagePlaceHolder(62, context);
  //           }),
  //         ),
  //       ),
  //       /*CircleAvatar(
  //     radius: 40,
  //     backgroundColor: colors.primary,
  //     child: profileImage != ""
  //         ? ClipRRect(
  //             borderRadius: BorderRadius.circular(40),
  //             child: FadeInImage(
  //               fadeInDuration: Duration(milliseconds: 150),
  //               image: NetworkImage(profileImage),
  //               height: 100.0,
  //               width: 100.0,
  //               fit: BoxFit.cover,
  //               placeholder: placeHolder(100),
  //               imageErrorBuilder: (context, error, stackTrace) =>
  //                   erroWidget(100),
  //             ))
  //         : Icon(
  //             Icons.account_circle,
  //             size: 80,
  //             color: Theme.of(context).colorScheme.white,
  //           ),
  //   ),*/
  //       // if (CUR_USERID != null)
  //       //   Positioned.directional(
  //       //       textDirection: Directionality.of(context),
  //       //       end: 20,
  //       //       bottom: 5,
  //       //       child: Container(
  //       //         height: 20,
  //       //         width: 20,
  //       //         child: InkWell(
  //       //           child: Icon(
  //       //             Icons.edit,
  //       //             color: Theme.of(context).colorScheme.white,
  //       //             size: 10,
  //       //           ),
  //       //           onTap: () {
  //       //             if (mounted) {
  //       //               onBtnSelected!();
  //       //             }
  //       //           },
  //       //         ),
  //       //         decoration: BoxDecoration(
  //       //             color: colors.primary,
  //       //             borderRadius: const BorderRadius.all(
  //       //               Radius.circular(20),
  //       //             ),
  //       //             border: Border.all(color: colors.primary)),
  //       //       )),
  //     ],
  //   );
  // }

//==============================================================================
//============================== First Header ==================================

  getFirstHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 5.0),
      child: Container(
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            children: <Widget>[
              setSallerName(),
              getDivider(),
              setMobileNo(),
              getDivider(),
              setEmail(),
              getDivider(),
              setAddress(),
            ],
          ),
        ),
      ),
    );
  }

//==============================================================================
//============================== Divider =======================================

  getDivider() {
    return Divider(
      height: 1,
      color: lightBlack,
    );
  }

//==============================================================================
//=========================== Saller Name ======================================

  setSallerName() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.person_outlined,
            color: primary,
            size: 27,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "NAME_LBL")!,
                    style: Theme.of(this.context).textTheme.caption!.copyWith(
                          color: lightBlack2,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  name != "" && name != null
                      ? Text(
                          name!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      : Text(
                          getTranslated(context, "NotAdded")!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 20,
              color: lightBlack,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                          child: Text(
                            getTranslated(context, "ADD_NAME_LBL")!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: fontColor),
                          ),
                        ),
                        Divider(color: lightBlack),
                        Form(
                          key: sellernameKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(

                              // decoration: BoxDecoration(
                              //     border: Border.all(color: lightBlack),
                              //     borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                child: TextFormField(
                                  // decoration: InputDecoration(
                                  //   border: InputBorder.none
                                  // ),
                                  keyboardType: TextInputType.text,
                                  style: Theme.of(this.context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: lightBlack,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  validator: (val) =>
                                      validateUserName(val, context),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: nameC,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "CANCEL")!,
                          style: TextStyle(
                            color: lightBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "SAVE_LBL")!,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          final form = sellernameKey.currentState!;
                          if (form.validate()) {
                            form.save();
                            setState(
                              () {
                                name = nameC!.text;
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

//==============================================================================
//============================= Mobile Number ==================================

  setMobileNo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.phone_in_talk_outlined,
            color: primary,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTranslated(context, "MOBILEHINT_LBL")!,
                  style: Theme.of(this.context).textTheme.caption!.copyWith(
                      color: lightBlack2, fontWeight: FontWeight.normal),
                ),
                mobile != null && mobile != ""
                    ? Text(
                        mobile!,
                        style: Theme.of(this.context)
                            .textTheme
                            .subtitle2!
                            .copyWith(
                              color: lightBlack,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    : Text(
                        getTranslated(context, "NotAdded")!,
                        style: Theme.of(this.context)
                            .textTheme
                            .subtitle2!
                            .copyWith(
                              color: lightBlack,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//==============================================================================
//=============================== set Email ====================================

  setEmail() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.email_outlined,
            color: primary,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "Email")!,
                    style: Theme.of(this.context).textTheme.caption!.copyWith(
                        color: lightBlack2, fontWeight: FontWeight.normal),
                  ),
                  email != "" && email != null
                      ? Text(
                          email!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      : Text(
                          getTranslated(context, "NotAdded")!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 20,
              color: lightBlack,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                          child: Text(
                            getTranslated(context, "addEmail")!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: fontColor),
                          ),
                        ),
                        Divider(color: lightBlack),
                        Form(
                          key: emailKey,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: Theme.of(this.context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      color: lightBlack,
                                      fontWeight: FontWeight.normal),
                              validator: (val) => validateField(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: emailC,
                            ),
                          ),
                        )
                      ],
                    ),
                    actions: <Widget>[
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "CANCEL")!,
                          style: TextStyle(
                            color: lightBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "SAVE_LBL")!,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          final form = emailKey.currentState!;
                          if (form.validate()) {
                            form.save();
                            setState(
                              () {
                                email = emailC!.text;
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

//==============================================================================
//============================ set Address =====================================

  setAddress() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.location_on_outlined,
            color: primary,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "Addresh")!,
                    style: Theme.of(this.context).textTheme.caption!.copyWith(
                          color: lightBlack2,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  address != "" && address != null
                      ? Text(
                          address!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      : Text(
                          getTranslated(context, "NotAdded")!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 20,
              color: lightBlack,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                          child: Text(
                            getTranslated(context, "AddAddress")!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: fontColor),
                          ),
                        ),
                        Divider(color: lightBlack),
                        Form(
                          key: addressKey,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: Theme.of(this.context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: lightBlack,
                                    fontWeight: FontWeight.normal,
                                  ),
                              validator: (val) => validateField(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: addressC,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "CANCEL")!,
                          style: TextStyle(
                            color: lightBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "SAVE_LBL")!,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          final form = addressKey.currentState!;
                          if (form.validate()) {
                            form.save();
                            setState(
                              () {
                                address = addressC!.text;
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

//==============================================================================
//============================ Second Header ===================================

  getSecondHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 5.0),
      child: Container(
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            children: <Widget>[
              setStoreName(),
              getDivider(),
              setStoreURL(),
              getDivider(),
              setDescription(),
            ],
          ),
        ),
      ),
    );
  }

//==============================================================================
//============================ Store Name  =====================================

  setStoreName() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.store_outlined,
            color: primary,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "StoreName")!,
                    style: Theme.of(this.context).textTheme.caption!.copyWith(
                        color: lightBlack2, fontWeight: FontWeight.normal),
                  ),
                  storename != "" && storename != null
                      ? Text(
                          storename!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      : Text(
                          getTranslated(context, "NotAdded")!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 20,
              color: lightBlack,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                          child: Text(
                            getTranslated(context, "addStoreName")!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: fontColor),
                          ),
                        ),
                        Divider(color: lightBlack),
                        Form(
                          key: storenameKey,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: Theme.of(this.context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: lightBlack,
                                    fontWeight: FontWeight.normal,
                                  ),
                              validator: (val) => validateField(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: storenameC,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "CANCEL")!,
                          style: TextStyle(
                            color: lightBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "SAVE_LBL")!,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          final form = storenameKey.currentState!;
                          if (form.validate()) {
                            form.save();
                            setState(
                              () {
                                storename = storenameC!.text;
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

//==============================================================================
//============================= Store URL ======================================

  setStoreURL() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.link_outlined,
            color: primary,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "StoreURL")!,
                    style: Theme.of(this.context).textTheme.caption!.copyWith(
                        color: lightBlack2, fontWeight: FontWeight.normal),
                  ),
                  storeurl != "" && storeurl != null
                      ? Text(
                          storeurl!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      : Text(
                          getTranslated(context, "NoURL")!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 20,
              color: lightBlack,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                          child: Text(
                            getTranslated(context, "addURL")!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: fontColor),
                          ),
                        ),
                        Divider(color: lightBlack),
                        Form(
                          key: storeurlKey,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: Theme.of(this.context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: lightBlack,
                                    fontWeight: FontWeight.normal,
                                  ),
                              validator: (val) => validateField(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: storeurlC,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "CANCEL")!,
                          style: TextStyle(
                            color: lightBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "SAVE_LBL")!,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          final form = storeurlKey.currentState!;
                          if (form.validate()) {
                            form.save();
                            setState(
                              () {
                                storeurl = storeurlC!.text;
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

//==============================================================================
//============================ Description =====================================

  setDescription() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.description_outlined,
            color: primary,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "Description")!,
                    style: Theme.of(this.context).textTheme.caption!.copyWith(
                        color: lightBlack2, fontWeight: FontWeight.normal),
                  ),
                  storeDesc != "" && storeDesc != null
                      ? Text(
                          storeDesc!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                          overflow: TextOverflow.ellipsis,
                        )
                      : Text(
                          getTranslated(context, "NoURL")!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 20,
              color: lightBlack,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                          child: Text(
                            getTranslated(context, "addDescription")!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: fontColor),
                          ),
                        ),
                        Divider(color: lightBlack),
                        Form(
                          key: storeDescKey,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: Theme.of(this.context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: lightBlack,
                                    fontWeight: FontWeight.normal,
                                  ),
                              validator: (val) => validateField(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: storeDescC,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "CANCEL")!,
                          style: TextStyle(
                            color: lightBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "SAVE_LBL")!,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          final form = storeDescKey.currentState!;
                          if (form.validate()) {
                            form.save();
                            setState(
                              () {
                                storeDesc = storeDescC!.text;
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

//==============================================================================
//============================ Third Header ====================================

  getThirdHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 5.0),
      child: Container(
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              setAccountNumber(),
              getDivider(),
              setAccountName(),
              getDivider(),
              setBankCode(),
              getDivider(),
              setBankName(),
            ],
          ),
        ),
      ),
    );
  }

//==============================================================================
//============================ Account Number  =================================

  setAccountNumber() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.format_list_numbered_outlined,
            color: primary,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "AccountNumber")!,
                    style: Theme.of(this.context).textTheme.caption!.copyWith(
                        color: lightBlack2, fontWeight: FontWeight.normal),
                  ),
                  accNo != "" && accNo != null
                      ? Text(
                          accNo!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      : Text(
                          getTranslated(context, "NotAdded")!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 20,
              color: lightBlack,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                          child: Text(
                            getTranslated(context, "addAccontNumber")!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: fontColor),
                          ),
                        ),
                        Divider(color: lightBlack),
                        Form(
                          key: accnumberKey,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: Theme.of(this.context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: lightBlack,
                                    fontWeight: FontWeight.normal,
                                  ),
                              validator: (val) => validateField(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: accnumberC,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "CANCEL")!,
                          style: TextStyle(
                            color: lightBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "SAVE_LBL")!,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          final form = accnumberKey.currentState!;
                          if (form.validate()) {
                            form.save();
                            setState(
                              () {
                                accNo = accnumberC!.text;
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

//==============================================================================
//============================ Account Name  ===================================

  setAccountName() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.import_contacts_outlined,
            color: primary,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "AccountName")!,
                    style: Theme.of(this.context).textTheme.caption!.copyWith(
                        color: lightBlack2, fontWeight: FontWeight.normal),
                  ),
                  accname != "" && accname != null
                      ? Text(
                          accname!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      : Text(
                          getTranslated(context, "NotAdded")!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 20,
              color: lightBlack,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                          child: Text(
                            getTranslated(context, "addAccountName")!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: fontColor),
                          ),
                        ),
                        Divider(color: lightBlack),
                        Form(
                          key: accnameKey,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: Theme.of(this.context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: lightBlack,
                                    fontWeight: FontWeight.normal,
                                  ),
                              validator: (val) => validateField(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: accnameC,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "CANCEL")!,
                          style: TextStyle(
                            color: lightBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "SAVE_LBL")!,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          final form = accnameKey.currentState!;
                          if (form.validate()) {
                            form.save();
                            setState(
                              () {
                                accname = accnameC!.text;
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

//==============================================================================
//============================ Account Number  =================================

  setBankCode() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.request_quote_outlined,
            color: primary,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "BankCode")!,
                    style: Theme.of(this.context).textTheme.caption!.copyWith(
                        color: lightBlack2, fontWeight: FontWeight.normal),
                  ),
                  bankcode != "" && bankcode != null
                      ? Text(
                          bankcode!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      : Text(
                          getTranslated(context, "NotAdded")!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 20,
              color: lightBlack,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                          child: Text(
                            getTranslated(context, "addBankCode")!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: fontColor),
                          ),
                        ),
                        Divider(color: lightBlack),
                        Form(
                          key: bankcodeKey,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: Theme.of(this.context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: lightBlack,
                                    fontWeight: FontWeight.normal,
                                  ),
                              validator: (val) => validateField(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: bankcodeC,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "CANCEL")!,
                          style: TextStyle(
                            color: lightBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "SAVE_LBL")!,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          final form = bankcodeKey.currentState!;
                          if (form.validate()) {
                            form.save();
                            setState(
                              () {
                                bankcode = bankcodeC!.text;
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

//==============================================================================
//============================ setBankName =====================================

  setBankName() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.account_balance_outlined,
            color: primary,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "BankName")!,
                    style: Theme.of(this.context).textTheme.caption!.copyWith(
                        color: lightBlack2, fontWeight: FontWeight.normal),
                  ),
                  bankname != "" && bankname != null
                      ? Text(
                          bankname!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      : Text(
                          getTranslated(context, "NotAdded")!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 20,
              color: lightBlack,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                          child: Text(
                            getTranslated(context, "addBankName")!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: fontColor),
                          ),
                        ),
                        Divider(color: lightBlack),
                        Form(
                          key: banknameKey,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: Theme.of(this.context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: lightBlack,
                                    fontWeight: FontWeight.normal,
                                  ),
                              validator: (val) => validateField(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: banknameC,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "CANCEL")!,
                          style: TextStyle(
                            color: lightBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "SAVE_LBL")!,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          final form = banknameKey.currentState!;
                          if (form.validate()) {
                            form.save();
                            setState(
                              () {
                                bankname = banknameC!.text;
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

//==============================================================================
//========================= Fourth Header ======================================

  getFurthHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 5.0),
      child: Container(
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              setLatitude(),
              getDivider(),
              setLongitude(),
              getDivider(),
              setTaxName(),
              getDivider(),
              setTaxNumber(),
              getDivider(),
              setPanNumber(),
            ],
          ),
        ),
      ),
    );
  }

//==============================================================================
//============================== Latitude ======================================

  setLatitude() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.travel_explore_outlined,
            color: primary,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "Latitute")!,
                    style: Theme.of(this.context).textTheme.caption!.copyWith(
                        color: lightBlack2, fontWeight: FontWeight.normal),
                  ),
                  latitutute != "" && latitutute != null
                      ? Text(
                          latitutute!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      : Text(
                          getTranslated(context, "NotAdded")!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 20,
              color: lightBlack,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                          child: Text(
                            getTranslated(context, "AddLatitute")!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: fontColor),
                          ),
                        ),
                        Divider(color: lightBlack),
                        Form(
                          key: latitututeKey,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: Theme.of(this.context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: lightBlack,
                                    fontWeight: FontWeight.normal,
                                  ),
                              validator: (val) => validateField(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: latitututeC,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "CANCEL")!,
                          style: TextStyle(
                            color: lightBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "SAVE_LBL")!,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          final form = latitututeKey.currentState!;
                          if (form.validate()) {
                            form.save();
                            setState(
                              () {
                                latitutute = latitututeC!.text;
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

//==============================================================================
//============================ Longitude =======================================

  setLongitude() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.language_outlined,
            color: primary,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "Longitude")!,
                    style: Theme.of(this.context).textTheme.caption!.copyWith(
                        color: lightBlack2, fontWeight: FontWeight.normal),
                  ),
                  longitude != "" && longitude != null
                      ? Text(
                          longitude!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      : Text(
                          getTranslated(context, "NotAdded")!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 20,
              color: lightBlack,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                          child: Text(
                            getTranslated(context, "AddLongitude")!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: fontColor),
                          ),
                        ),
                        Divider(color: lightBlack),
                        Form(
                          key: longituteKey,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: Theme.of(this.context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: lightBlack,
                                    fontWeight: FontWeight.normal,
                                  ),
                              validator: (val) => validateField(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: longituteC,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "CANCEL")!,
                          style: TextStyle(
                            color: lightBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "SAVE_LBL")!,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          final form = longituteKey.currentState!;
                          if (form.validate()) {
                            form.save();
                            setState(
                              () {
                                longitude = longituteC!.text;
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

//==============================================================================
//============================== Tax Name ======================================

  setTaxName() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.text_snippet_outlined,
            color: primary,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "TaxName")!,
                    style: Theme.of(this.context).textTheme.caption!.copyWith(
                        color: lightBlack2, fontWeight: FontWeight.normal),
                  ),
                  taxname != "" && taxname != null
                      ? Text(
                          taxname!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      : Text(
                          getTranslated(context, "NotAdded")!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 20,
              color: lightBlack,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                          child: Text(
                            getTranslated(context, "addTaxName")!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: fontColor),
                          ),
                        ),
                        Divider(color: lightBlack),
                        Form(
                          key: taxnameKey,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: Theme.of(this.context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: lightBlack,
                                    fontWeight: FontWeight.normal,
                                  ),
                              validator: (val) => validateField(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: taxnameC,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "CANCEL")!,
                          style: TextStyle(
                            color: lightBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "SAVE_LBL")!,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          final form = taxnameKey.currentState!;
                          if (form.validate()) {
                            form.save();
                            setState(
                              () {
                                taxname = taxnameC!.text;
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

//==============================================================================
//========================== setTaxNumber ======================================

  setTaxNumber() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.assignment_outlined,
            color: primary,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "TaxNumber")!,
                    style: Theme.of(this.context).textTheme.caption!.copyWith(
                        color: lightBlack2, fontWeight: FontWeight.normal),
                  ),
                  taxnumber != "" && taxnumber != null
                      ? Text(
                          taxnumber!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      : Text(
                          getTranslated(context, "NotAdded")!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 20,
              color: lightBlack,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                          child: Text(
                            getTranslated(context, "addTaxNumber")!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: fontColor),
                          ),
                        ),
                        Divider(color: lightBlack),
                        Form(
                          key: taxnumberKey,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: Theme.of(this.context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: lightBlack,
                                    fontWeight: FontWeight.normal,
                                  ),
                              validator: (val) => validateField(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: taxnumberC,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "CANCEL")!,
                          style: TextStyle(
                            color: lightBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "SAVE_LBL")!,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          final form = taxnumberKey.currentState!;
                          if (form.validate()) {
                            form.save();
                            setState(
                              () {
                                taxnumber = taxnumberC!.text;
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

//==============================================================================
//============================ Pan Number ======================================

  setPanNumber() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.picture_in_picture_outlined,
            color: primary,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslated(context, "PanNumber")!,
                    style: Theme.of(this.context).textTheme.caption!.copyWith(
                        color: lightBlack2, fontWeight: FontWeight.normal),
                  ),
                  pannumber != "" && pannumber != null
                      ? Text(
                          pannumber!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        )
                      : Text(
                          getTranslated(context, "NotAdded")!,
                          style: Theme.of(this.context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                color: lightBlack,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 20,
              color: lightBlack,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                          child: Text(
                            getTranslated(context, "addPanNumber")!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: fontColor),
                          ),
                        ),
                        Divider(color: lightBlack),
                        Form(
                          key: pannumberKey,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: Theme.of(this.context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: lightBlack,
                                    fontWeight: FontWeight.normal,
                                  ),
                              validator: (val) => validateField(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: pannumberC,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "CANCEL")!,
                          style: TextStyle(
                            color: lightBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      new ElevatedButton(
                        child: Text(
                          getTranslated(context, "SAVE_LBL")!,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          final form = pannumberKey.currentState!;
                          if (form.validate()) {
                            form.save();
                            setState(
                              () {
                                pannumber = pannumberC!.text;
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

//==============================================================================
//============================ Change Pass =====================================

  changePass() {
    return Container(
      height: 60,
      width: width,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              top: 15.0,
              bottom: 15.0,
            ),
            child: Text(
              getTranslated(context, "CHANGE_PASS_LBL")!,
              style: Theme.of(this.context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: fontColor, fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {
            _showDialog();
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ChangePassPage()),
            // );
           // _showDialog();
          },
        ),
      ),
    );
  }

  _showDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                      child: Text(
                        getTranslated(context, "CHANGE_PASS_LBL")!,
                        style: Theme.of(this.context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: fontColor),
                      ),
                    ),
                    Divider(color: lightBlack),
                    Form(
                      key: _formKey,
                      child: new Column(
                        children: <Widget>[
                          // Padding(
                          //   padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          //   child: TextFormField(
                          //     keyboardType: TextInputType.text,
                          //     validator: (val) => validatePass(val, context),
                          //     autovalidateMode:
                          //         AutovalidateMode.onUserInteraction,
                          //     decoration: InputDecoration(
                          //       hintText:
                          //           getTranslated(context, "CUR_PASS_LBL")!,
                          //       hintStyle: Theme.of(this.context)
                          //           .textTheme
                          //           .subtitle1!
                          //           .copyWith(
                          //               color: lightBlack,
                          //               fontWeight: FontWeight.normal),
                          //       suffixIcon: IconButton(
                          //         icon: Icon(_showCurPassword
                          //             ? Icons.visibility
                          //             : Icons.visibility_off),
                          //         iconSize: 20,
                          //         color: lightBlack,
                          //         onPressed: () {
                          //           setStater(
                          //             () {
                          //               _showCurPassword = !_showCurPassword;
                          //             },
                          //           );
                          //         },
                          //       ),
                          //     ),
                          //     obscureText: !_showCurPassword,
                          //     controller: curPassC,
                          //   ),
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          //   child: TextFormField(
                          //     keyboardType: TextInputType.text,
                          //     validator: (val) => validatePass(val, context),
                          //     autovalidateMode:
                          //         AutovalidateMode.onUserInteraction,
                          //     decoration: new InputDecoration(
                          //       hintText:
                          //           getTranslated(context, "NEW_PASS_LBL")!,
                          //       hintStyle: Theme.of(this.context)
                          //           .textTheme
                          //           .subtitle1!
                          //           .copyWith(
                          //               color: lightBlack,
                          //               fontWeight: FontWeight.normal),
                          //       suffixIcon: IconButton(
                          //         icon: Icon(_showPassword
                          //             ? Icons.visibility
                          //             : Icons.visibility_off),
                          //         iconSize: 20,
                          //         color: lightBlack,
                          //         onPressed: () {
                          //           setStater(
                          //             () {
                          //               _showPassword = !_showPassword;
                          //             },
                          //           );
                          //         },
                          //       ),
                          //     ),
                          //     obscureText: !_showPassword,
                          //     controller: newPassC,
                          //   ),
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          //   child: TextFormField(
                          //     keyboardType: TextInputType.text,
                          //     validator: (value) {
                          //
                          //       if (value!.length == 0)
                          //         return getTranslated(
                          //             context, "CON_PASS_REQUIRED_MSG")!;
                          //       if (value != newPass) {
                          //         confPassC!.text = "";
                          //         return getTranslated(
                          //             context, "CON_PASS_NOT_MATCH_MSG")!;
                          //       }
                          //       else {
                          //         return null;
                          //       }
                          //     },
                          //     autovalidateMode:
                          //         AutovalidateMode.onUserInteraction,
                          //     decoration: new InputDecoration(
                          //         hintText: getTranslated(
                          //             context, "CONFIRMPASSHINT_LBL")!,
                          //         hintStyle: Theme.of(this.context)
                          //             .textTheme
                          //             .subtitle1!
                          //             .copyWith(
                          //                 color: lightBlack,
                          //                 fontWeight: FontWeight.normal),
                          //         suffixIcon: IconButton(
                          //           icon: Icon(_showCmPassword
                          //               ? Icons.visibility
                          //               : Icons.visibility_off),
                          //           iconSize: 20,
                          //           color: lightBlack,
                          //           onPressed: () {
                          //             setStater(() {
                          //               _showCmPassword = !_showCmPassword;
                          //             });
                          //           },
                          //         )),
                          //     obscureText: !_showCmPassword,
                          //     controller: confPassC,
                          //     onChanged: (v) => setState(
                          //       () {
                          //         confPass = v;
                          //       },
                          //     ),
                          //   ),
                          // ),


                          Container(
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: TextField(
                                cursorColor: primary ,
                                controller: curPassController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 10,left: 10),

                                    border: OutlineInputBorder(
                                    ),
                                    enabledBorder:  OutlineInputBorder(
                                      borderSide:  BorderSide(color:  primary  , width: 0.0),
                                    ),
                                    focusedBorder:  OutlineInputBorder(
                                      borderSide:  BorderSide(color:  primary  , width: 2),
                                    ),

                                    hintText: "Current Password",
                                    // suffixIcon: IconButton(
                                    //   icon: Icon(_showCurPassword
                                    //       ? Icons.visibility
                                    //       : Icons.visibility_off),
                                    //   iconSize: 20,
                                    //   color: lightBlack,
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       _showCurPassword=! _showCurPassword;
                                    //     });
                                    //   },
                                    // ),

                                ),
                                obscureText: _showCurPassword,

                               ),
                            ),
                          ),
                          Container(
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: TextField(
                                controller: newPassController,
                                cursorColor:  primary  ,

                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 10,left: 10),

                                    border: OutlineInputBorder(
                                    ),
                                    enabledBorder:  OutlineInputBorder(
                                      borderSide:  BorderSide(color:  primary  , width: 0.0),
                                    ),
                                    focusedBorder:  OutlineInputBorder(
                                      borderSide:  BorderSide(color:  primary , width: 2),
                                    ),

                                    hintText: "New Password",
                                    // suffixIcon: IconButton(
                                    //   icon: Icon(_showPassword
                                    //       ? Icons.visibility
                                    //       : Icons.visibility_off),
                                    //   iconSize: 20,
                                    //   color: lightBlack,
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       _showPassword=! _showPassword;
                                    //     });
                                    //   },
                                    // )
                                ),
                                obscureText: _showPassword,

                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: TextField(
                                controller: againPassController,
                                cursorColor:  primary  ,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(

                                    border: OutlineInputBorder(
                                    ),
                                    enabledBorder:  OutlineInputBorder(
                                      borderSide:  BorderSide(color: primary  , width: 0.0),
                                    ),
                                    focusedBorder:  OutlineInputBorder(
                                      borderSide:  BorderSide(color: primary , width: 2),
                                    ),
                                      contentPadding: EdgeInsets.only(top: 10,left: 10),
                                    hintText: "Confirm Password",
                                    // suffixIcon: IconButton(
                                    //   icon: Icon(_showCmPassword
                                    //       ? Icons.visibility
                                    //       : Icons.visibility_off),
                                    //   iconSize: 20,
                                    //   color: lightBlack,
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       _showCmPassword=! _showCmPassword;
                                    //     });
                                    //   },
                                    // )
                                ),
                                obscureText: _showCmPassword,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                new ElevatedButton(
                    child: Text(
                      getTranslated(context, "CANCEL")!,
                      style: Theme.of(this.context)
                          .textTheme
                          .subtitle2!
                          .copyWith(
                              color: lightBlack, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                new ElevatedButton(
                  child: Text(
                    getTranslated(context, "SAVE_LBL")!,
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                        color: fontColor, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    // final form = _formKey.currentState!;
                    // if (form.validate()) {
                    //   curPass = curPassC!.text;
                    //   newPass = newPassC!.text;
                    //   form.save();
                    //   setState(
                    //     () {
                    //       Navigator.pop(context);
                    //     },
                    //   );
                    //    changePassWord();
                    // }
                    if(curPassController.text.isNotEmpty){
                      if(newPassController.text == againPassController.text){
                        changePassWord();
                      }else{
                        setSnackbar("Password Not Match");
                      }
                    }else{
                      setSnackbar("Current Password is Required");
                    }
                  },
                )
              ],
            );
          },
        );
      },
    );
  }
//==============================================================================
//==================== Same API But Only PassPassword ==========================

  Future<void> changePassWord() async {
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      var parameter = {
        Id: CUR_USERID,
        Name: name ?? "",
        Mobile: mobile ?? "",
        Email: email ?? "",
        Address: address ?? "",
        Storename: storename ?? "",
        Storeurl: storeurl ?? "",
        storeDescription: storeDesc ?? "",
        accountNumber: accNo ?? "",
        accountName: accname ?? "",
        bankCode: bankcode ?? "",
        bankName: bankname ?? "",
        Latitude: latitutute ?? "",
        Longitude: longitude ?? "",
        taxName: taxname ?? "",
        taxNumber: taxnumber ?? "",
        panNumber: pannumber ?? "",
        STATUS: status ?? "1",
        OLDPASS: curPassController.text,
        NEWPASS: newPassController.text,
      };
      apiBaseHelper.postAPICall(updateUserApi, parameter).then(
        (getdata) async {
          bool error = getdata["error"];
          String? msg = getdata["message"];
          if (!error) {
            curPassController.clear();
            newPassController.clear();
            againPassController.clear();
            Navigator.pop(context);
            setSnackbar(msg!);
          } else {
            Navigator.pop(context);
            setSnackbar(msg!);
          }
        },
        onError: (error) {
          setSnackbar(error.toString());
        },
      );
    } else {
      Future.delayed(Duration(seconds: 2)).then(
        (_) async {
          await buttonController!.reverse();
          setState(
            () {
              _isNetworkAvail = false;
            },
          );
        },
      );
    }
  }
//==============================================================================
//============================== LoginBtn ======================================


  updateBtn() {
    return AppBtn(
      title: getTranslated(context, "Update Profile")!,
      btnAnim: buttonSqueezeanimation,
      btnCntrl: buttonController,
      onBtnSelected: () async {
        _playAnimation();
        checkNetwork();
      },
    );
  }
//==============================================================================
//========================= circular Progress ==================================

  Widget showCircularProgress(bool _isProgress, Color color) {
    if (_isProgress) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(color),
        ),
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

//==============================================================================
//========================= everything is completed ============================

}

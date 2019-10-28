
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:honoo/Model/Honoo.dart' as Honoo;
import 'package:honoo/ViewModel/HonooViewModel.dart';
import 'package:honoo/Model/AppState.dart';
import 'package:honoo/ViewModel/ProfilePageViewModel.dart';
import 'dart:math';



class HonooCard extends StatelessWidget {

  final Honoo.Honoo honoo;

  Color themeColor() {
    return  honoo.theme == Honoo.Theme.light ? Colors.black : Colors.white;
  }

  Color secondaryThemeColor() {
    return honoo.theme == Honoo.Theme.dark ? Colors.black : Colors.white;
  }

  HonooCard({@required this.honoo});

  @override
  Widget build(BuildContext context) {
    
    return StoreConnector<AppState,ProfilePageViewModel>(
      converter: ProfilePageViewModel.fromStore,
      builder: (BuildContext context,ProfilePageViewModel model) {
        return Container(
          width: 300,
          height: !model.settings["includeInfo"] ? 550:625,

          decoration: BoxDecoration(
              color: secondaryThemeColor(),
              boxShadow: [
                BoxShadow(
                    color: Colors.black45,
                    spreadRadius: 5,
                    blurRadius: 10
                )
              ]
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if(model.settings["includeInfo"] && model.profilePic != null && honoo.info != null)
               Padding(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(model.profilePic!=null)
                        Container(
                          width: 70,
                          height: 70,
                          child: Image.file(model.profilePic,fit: BoxFit.cover),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color:  themeColor(),
                              )
                          ),
                        ),

                      Padding(padding: EdgeInsets.only(left: 2.5,right: 2.5)),
                      Flexible(
                        flex: 3,
                        child: Container(
                          height: 70,
                            child: Padding(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  if(model.contacts['email'] != "")
                                    Flexible(
                                      flex:1,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.alternate_email,size: 20,color: themeColor(),),
                                          Padding(padding: EdgeInsets.only(right: 5)),
                                          Text(model.contacts['email'],style: TextStyle(color: themeColor()),)
                                        ],
                                      ),
                                    ),
                                  if(model.contacts["telephone"] != "")
                                    Flexible(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.phone,size: 20,color: themeColor()),
                                          Padding(padding: EdgeInsets.only(right: 5)),
                                          Text(model.contacts['telephone'],style: TextStyle(color: themeColor()))
                                        ],
                                      ),
                                    ),
                                  if(model.contacts["telegram"] != "")
                                    Flexible(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Transform.rotate(angle:  -pi/4,child: Icon(Icons.send,size: 20,color: themeColor(),)),
                                          Padding(padding: EdgeInsets.only(right: 5)),
                                          Text(model.contacts['telegram'],style: TextStyle(color: themeColor()))
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color:  themeColor()
                              )
                          ),
                        ),
                      ),

                    ],
                  ),
                  padding: EdgeInsets.only(top: 5,left: 5,right: 5),
                ),

              Flexible(
                  flex: 2 ,
                  child: Padding(
                    child: Container(
                      child: Center(
                        child: Padding(
                            child: Text(honoo.text,maxLines: 6,textAlign: TextAlign.center,style: TextStyle(fontSize: 16,color: honoo.theme == Honoo.Theme.light ? Colors.black : Colors.white,)),
                            padding: EdgeInsets.only(left:35,right: 35)),
                      ),
                      decoration: BoxDecoration(
                          color: secondaryThemeColor(),
                          border: Border.all(
                            color:  themeColor(),
                          )
                      ),
                    ),
                    padding: EdgeInsets.only(top: 5,left: 5,right: 5),
                  )
              ),
              Expanded(
                  flex: 3,
                  child: Padding(
                      child: Container(
                        child: Image.file(honoo.photo,fit: BoxFit.cover),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color:themeColor()
                            )
                        ),
                      ),
                      padding: EdgeInsets.all(5))
              )
            ],
          ),
        );
      },

    );
  }
}

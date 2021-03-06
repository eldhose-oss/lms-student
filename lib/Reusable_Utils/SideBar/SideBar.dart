import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lm_student/App_Screens/ClassAnnouncement.dart';
import 'package:lm_student/App_Screens/LeaveApplication.dart';
import 'package:lm_student/App_Screens/LeaveHistory.dart';
import 'package:lm_student/App_Screens/LeaveStatus.dart';
import 'package:lm_student/App_Screens/MainPage.dart';
import 'package:lm_student/App_Screens/ProfileScreen.dart';
import 'package:lm_student/App_Screens/TimeTable.dart';
import 'package:lm_student/Models/User.dart';
import 'package:lm_student/Providers/UserProvider.dart';
import 'package:lm_student/Reusable_Utils/Responsive.dart';
import 'package:lm_student/Reusable_Utils/SideBar/SidebarListTile.dart';
import 'package:provider/provider.dart';
import 'package:lm_student/Reusable_Utils/Colors.dart' as color_mode;

import '../../App_Screens/DeptAnnouncement.dart';
import '../../App_Screens/Login_page.dart';
import '../../Resources/AuthMethods.dart';
import '../CustomPageRoute.dart';
import '../Dialog.dart';
class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  logoutDialog() async{
    await showDialog(
        barrierColor: Colors.white70,
        context: context,
        builder: (BuildContext context){
          return alertDialog(title: 'Do you want to logout?', onPressed: logoutUser, button1: 'Cancel', button2: 'Log out', context: context);
        });
  }
  void logoutUser() async{
    String finalResult = await AuthMethods().logoutUser();
    if(finalResult == "success"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }
  @override
  Widget build(BuildContext context) {
    final UserModel _userModel = Provider
        .of<UserProvider>(context)
        .getUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: screenLayout(340, context),
            child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                    image:  DecorationImage(
                        image: NetworkImage('https://www.pixelstalk.net/wp-content/uploads/2016/10/Aqua-Blue-Photos.jpg'),
                        fit: BoxFit.cover,
                        isAntiAlias: true,
                        filterQuality: FilterQuality.high
                    )
                ),
                accountName: Text(_userModel.fullName,
                  style: TextStyle(color: color_mode.primaryColor,
                      fontWeight: FontWeight.bold
                  ),
                ),
                accountEmail: Text(_userModel.emailAddress,
                  style: TextStyle(color: color_mode.primaryColor,
                      fontWeight: FontWeight.bold
                  ),
                ),
                currentAccountPicture: InkWell(
                  splashColor: color_mode.secondaryColor,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfileScreen()));
                  },
                  child: CircleAvatar(
                    radius: screenLayout(120, context),
                    backgroundImage: NetworkImage(_userModel.imageUrl),
                  ),
                )
            ),
          ),
          sidebarListTile(
              title: 'Home',
              leadingIcon:Icons.home_outlined,
              onTap: (){}),
          Divider(
            color: color_mode.tertiaryColor,
          ),
          sidebarListTile(
              title: 'Class Announcement',
              leadingIcon:Icons.notification_important_outlined,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ClassAnnouncement()));

              }),
          sidebarListTile(
              title: 'Dept Announcement',
              leadingIcon:Icons.notification_important_outlined,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const DeptAnnounce()));
              }),
          sidebarListTile(
              title: 'Leave Application',
              leadingIcon:FontAwesomeIcons.paperPlane,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveApplication()));
              }),
          sidebarListTile(
              title: 'Leave Status',
              leadingIcon:FontAwesomeIcons.barsProgress,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveStatus()));
              }),
          sidebarListTile(
              title: 'Leave History',
              leadingIcon:Icons.history,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveHistory()));

              }),
          sidebarListTile(
              title: 'TimeTable',
              leadingIcon:FontAwesomeIcons.tableColumns,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TimeTable()));

              }),
          Divider(
            color: color_mode.tertiaryColor,
          ),
          sidebarListTile(
              title: 'Logout',
              leadingIcon:Icons.logout,
              onTap: logoutDialog),
        ],
      ),
    );
  }
}



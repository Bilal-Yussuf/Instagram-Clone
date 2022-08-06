import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenSLayout;
  final Widget mobileScreenSLayout;

  const ResponsiveLayout({Key? key,required this.webScreenSLayout, required this.mobileScreenSLayout}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
        builder: (context, contraints) {
          if(contraints.maxWidth > webScreenSize){
            // Web Screen
            return webScreenSLayout;
          }
          // Mobile Screen
          return mobileScreenSLayout;
        } );
  }
}
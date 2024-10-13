import 'package:flutter/material.dart';

import '../../components/constants/stack_background_manager.dart';
class SearchRoute extends StatefulWidget {
  const SearchRoute({super.key});

  @override
  State<SearchRoute> createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: stackBackGroundManager(),
    );
  }
  List<Widget> screenWidgets ()=>[];
}

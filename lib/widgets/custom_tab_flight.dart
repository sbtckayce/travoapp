import 'package:flutter/material.dart';


class CustomTabFlight extends StatelessWidget {
  const CustomTabFlight({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        width: double.infinity,
     
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
       
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(name,style:const TextStyle(fontSize: 12,),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis),
      ),
    );
  }
}

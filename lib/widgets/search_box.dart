import 'package:flutter/material.dart';


class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key, this.onTap, required this.searchController, required this.horizontal, required this.vertical, required this.hintText, this.suffixIcon, 
  });
  final Function()? onTap;
  final String hintText;
  final TextEditingController searchController;
  final double horizontal;
  final double vertical;
  final Widget? suffixIcon;
 
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> valueIsSuffixIcon = ValueNotifier(false);
  return  ValueListenableBuilder(valueListenable: valueIsSuffixIcon, builder: (context, value, child) {
      return  Container(
          width: double.infinity,
          height: 50,
          margin:  EdgeInsets.symmetric(horizontal: horizontal,vertical: vertical),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:
                  Theme.of(context).colorScheme.onBackground),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              valueIsSuffixIcon.value =true;
            },
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            decoration: InputDecoration(
                suffixIcon: valueIsSuffixIcon.value ? suffixIcon : const SizedBox(),
                prefixIcon: GestureDetector(
                    onTap: onTap,
                    child: Icon(Icons.search_outlined,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary)),
                hintText: hintText,
                
                hintStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none),
          ),
        );
    },);
  }
}


import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;

  const HeaderWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal,
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        trailing: const Icon(
          Icons.sort,
          color: Colors.white,
          size: 30.0,
        ),
        onTap: () {},
      ),
    );
  }
}

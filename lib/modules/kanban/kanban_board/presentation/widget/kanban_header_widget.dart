import 'package:flutter/material.dart';
import 'package:flutter_design_extension/flutter_design_extension.dart';

class HeaderWidget extends StatelessWidget {
  final String title;

  const HeaderWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Card(
      color: theme.colors.brand.dark,
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: theme.colors.neutral.white,
          ),
        ),
        trailing: Icon(
          Icons.swap_horiz_rounded,
          color: theme.colors.neutral.white,
          size: 30.0,
        ),
        onTap: () {},
      ),
    );
  }
}

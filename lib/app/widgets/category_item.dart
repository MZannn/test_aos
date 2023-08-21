import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;

  const CategoryItem(this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      // padding: ,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Icon(icon, size: 20),
    );
  }
}

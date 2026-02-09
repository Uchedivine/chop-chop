import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String iconPath;
  final String name;

  const CategoryItem({
    super.key,
    required this.iconPath,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(iconPath, height: 35, width: 35, fit: BoxFit.contain),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              height: 1.1,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final void Function()? onTap;
  LikeButton({super.key, required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(isLiked ? Icons.favorite : Icons.favorite_border,
          color: isLiked ? Colors.red : Theme.of(context).colorScheme.primary),
    );
  }
}

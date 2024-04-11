import 'package:ease_studyante_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    Key? key,
    required this.name,
    required this.id,
    this.urlPhoto,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final String id;
  final String? urlPhoto;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: urlPhoto != null
                  ? Image.network(urlPhoto!).image
                  : Assets.images.noImage.image().image,
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(name),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[700]),
          ],
        ),
      ),
    );
  }
}

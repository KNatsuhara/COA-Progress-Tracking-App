import "package:flutter/material.dart";

class HomeTile extends StatelessWidget {
  final String tileName;
  final IconData tileIcon;
  final StatefulWidget tileRoute;
  final Color tileColor;
  final Color tileTextColor;

  const HomeTile({
    Key? key,
    required this.tileName,
    required this.tileIcon,
    required this.tileRoute,
    required this.tileColor,
    required this.tileTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return tileRoute;
                }));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: size.width * 0.35,
              width: size.width * 0.35,
              color: tileColor,
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Icon(
                    tileIcon,
                    color: tileTextColor,
                    size: size.width * 0.2,
                  ),
                  Text(
                    tileName,
                    style: TextStyle(
                        color: tileTextColor,
                        fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}

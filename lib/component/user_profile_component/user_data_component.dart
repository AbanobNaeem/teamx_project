import 'package:flutter/material.dart';

class UserDataComponent extends StatelessWidget {
  final String labelText;
  final String userData;
  final IconData icon ;

  const UserDataComponent({
    Key? key,
    required this.labelText,
    required this.userData,
    required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            width: 65,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Icon(
              icon  ,
              size: 35,
              color: Colors.grey[800],
            ),
          ),
        ),
        const SizedBox(width: 20,),
        Expanded(
          flex: 2,
          child: Text(
            labelText,
            style: const TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const  Expanded(
          child: Text(
            "-",
            style: TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            userData,
            style: TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

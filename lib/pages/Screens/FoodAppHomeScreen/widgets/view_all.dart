import 'package:flutter/material.dart';

import '../../../../Core/Utils/consts.dart';

class ViewAll extends StatelessWidget {
  const ViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Popular Now',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          GestureDetector(
            child: Row(
              children: [
                Text(
                  'View All',
                  style: TextStyle(
                    color: orange,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MomFoodTitle extends StatelessWidget implements PreferredSizeWidget {

  const MomFoodTitle({
    super.key,

  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Column(
        children: [
          SizedBox(
            width: 294,
            height: 43,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'M',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Encode Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: 'o',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 32,
                      fontFamily: 'Encode Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: 'm ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Encode Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: 'F',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Encode Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: 'Oo',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 32,
                      fontFamily: 'Encode Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: 'd',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Encode Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onProfileTap;
  final VoidCallback? onBackTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onProfileTap,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppTextStyles.appBarTitle),
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: onBackTap,
        child: Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.iconBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
      actions:
          onProfileTap != null
              ? [
                GestureDetector(
                  onTap: onProfileTap,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    width: 37,
                    decoration: BoxDecoration(
                      color: AppColors.iconBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.person, color: AppColors.iconColor),
                  ),
                ),
              ]
              : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

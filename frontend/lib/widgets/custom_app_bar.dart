import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/pages/about_us_page.dart';
import 'package:frontend/pages/cart.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/pages/profile.dart';
import 'package:frontend/services/persistant_storage.dart';
import 'package:get_it/get_it.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  bool showActions;
  bool allowBack;
  bool showAboutUs;
  TextStyle? style;

  CustomAppBar({
    super.key,
    required this.title,
    this.showActions = true,
    this.allowBack = true,
    this.showAboutUs = true,
    this.style,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final PersistentStorage persistentStorage = GetIt.I<PersistentStorage>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: widget.style ?? AppTextStyles.appBarTitle,
      ),
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      leading: Row(
        children: [
          SizedBox(child: goBack(context, widget.allowBack)),
          showAboutUs(context, widget.showAboutUs),
        ],
      ),
      actions: [
        FutureBuilder<List<Widget>>(
          future: getActions(context, widget.showActions, persistentStorage),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: snapshot.data!,
              );
            } else {
              return SizedBox(); // lub Container()
            }
          },
        ),
      ],
    );
  }

  Widget showAboutUs(BuildContext context, bool showAboutUs) {
    if (showAboutUs) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutUsPage()),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
              color: AppColors.iconBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.info_outline, color: AppColors.iconColor),
          ),
        ),
      );
    }
    return Container();
  }

  Widget goBack(BuildContext context, bool allowBack) {
    if (allowBack) {
      return GestureDetector(
        onTap: () {
          Navigator.maybePop(context);
        },
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
      );
    } else {
      return Container(margin: EdgeInsets.all(10));
    }
  }
}

Future<List<Widget>> getActions(
  BuildContext context,
  bool showActions,
  PersistentStorage persistentStorage,
) async {
  if (showActions) {
    String? apiToken = await persistentStorage.getData(StorageKeys.apiToken);
    if (apiToken == null) {
      apiToken = "";
    }
    if (apiToken.length > 1) {
      return [
        GestureDetector(
			
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
              color: AppColors.iconBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.person, color: AppColors.primary),
          ),
        ),
        GestureDetector(
		  key: const ValueKey('cart_icon_button'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          },
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
              color: AppColors.iconBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.shopping_cart, color: AppColors.iconColor),
          ),
        ),
      ];
    } else {
      return [
        GestureDetector(
		  key: const ValueKey('login_icon_button'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
              color: AppColors.iconBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.login, color: AppColors.iconColor),
          ),
        ),
      ];
    }
  } else {
    return [];
  }
}

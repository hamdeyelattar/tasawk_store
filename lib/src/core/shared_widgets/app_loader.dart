import 'package:flutter/cupertino.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Center(
      child: CupertinoActivityIndicator(
        radius: size.width * .04,
      ),
    );
    //  const AssetIcon(
    //   asset: AppAssets.loader,
    //   size: Pding.paddingXXL * 3,
    // );
  }
}

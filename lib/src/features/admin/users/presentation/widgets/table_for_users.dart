import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawk/src/core/common/widgets/text_app.dart';
import 'package:tasawk/src/core/extensions/context_extension.dart';
import 'package:tasawk/src/core/style/colors/colors_dark.dart';
import 'package:tasawk/src/core/style/fonts/font_family_helper.dart';
import 'package:tasawk/src/core/style/fonts/font_weight_helper.dart';
import 'package:tasawk/src/features/admin/users/data/models/get_all_users_response.dart';
import 'package:tasawk/src/features/admin/users/presentation/widgets/delete_user_icon.dart';
import 'package:tasawk/src/features/admin/users/presentation/widgets/table_cell_title.dart';

class TableForUsers extends StatelessWidget {
  const TableForUsers({required this.usersList, super.key});
  final List<UsersModel> usersList;
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: ColorsDark.blueLight),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FixedColumnWidth(100.w),
        1: const FlexColumnWidth(),
        2: FixedColumnWidth(90.w),
      },
      children: [
        const TableRow(
          decoration: BoxDecoration(color: ColorsDark.blueDark),
          children: [
            //name
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: TableCellTitleWidget(icon: Icons.person, title: 'Name'),
            ),
            //Email
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: TableCellTitleWidget(
                icon: Icons.email_sharp,
                title: 'Email',
              ),
            ),
            //delete
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: TableCellTitleWidget(
                icon: Icons.delete_forever_sharp,
                title: 'Delete',
              ),
            ),
          ],
        ),
        ...List.generate(
          usersList.length,
          (index) => TableRow(
            children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextApp(
                    text: usersList[index].name ?? '',
                    theme: context.textStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeightHelper.medium,
                      fontFamily: FontFamilyHelper.poppinsEnglish,
                    ),
                  ),
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextApp(
                    text: usersList[index].email ?? '',
                    theme: context.textStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeightHelper.medium,
                      fontFamily: FontFamilyHelper.poppinsEnglish,
                    ),
                  ),
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: DeleteUserIcon(
                  userId: usersList[index].id ?? '',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';
import 'package:victoria_game/app/global/themes/typography_theme.dart';

import '../controllers/profile_settings_faq_general_controller.dart';

class ProfileSettingsFaqGeneralView
    extends GetView<ProfileSettingsFaqGeneralController> {
  const ProfileSettingsFaqGeneralView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelListBuilder(faqItems: controller.faqItems),
      ),
    );
  }
}

class ExpansionPanelListBuilder extends StatefulWidget {
  const ExpansionPanelListBuilder({super.key, required this.faqItems});

  final List<FaqItem> faqItems;

  @override
  State<ExpansionPanelListBuilder> createState() =>
      _ExpansionPanelListBuilderState();
}

class _ExpansionPanelListBuilderState extends State<ExpansionPanelListBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ExpansionPanelList(
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            widget.faqItems[panelIndex].isExpanded =
                !widget.faqItems[panelIndex].isExpanded;
          });
        },
        children: widget.faqItems.map((item) {
          return ExpansionPanel(
            isExpanded: item.isExpanded,
            backgroundColor: item.isExpanded
                ? ColorsTheme.primaryColor
                : ColorsTheme.neutralColor[900],
            canTapOnHeader: true,
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text(
                  item.title,
                  style: TypographyTheme.bodyRegular.copyWith(
                      color: item.isExpanded
                          ? ColorsTheme.neutralColor[900]
                          : ColorsTheme.primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              );
            },
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: ColorsTheme.neutralColor[800],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.subtitle,
                    style: TypographyTheme.bodyRegular.copyWith(
                      color: ColorsTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(item.description),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

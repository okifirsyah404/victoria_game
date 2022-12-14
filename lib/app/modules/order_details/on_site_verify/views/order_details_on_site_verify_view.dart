import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/order_details_on_site_verify_controller.dart';

class OrderDetailsOnSiteVerifyView
    extends GetView<OrderDetailsOnSiteVerifyController> {
  const OrderDetailsOnSiteVerifyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderDetailsOnSiteVerifyView'),
        centerTitle: true,
      ),
      body: Center(
        child: CustonAnimatedIcon(),
      ),
    );
  }
}

class CustonAnimatedIcon extends StatefulWidget {
  const CustonAnimatedIcon({super.key});

  @override
  State<CustonAnimatedIcon> createState() => _CustonAnimatedIconState();
}

class _CustonAnimatedIconState extends State<CustonAnimatedIcon>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  }

  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 150,
      splashColor: Colors.greenAccent,
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_home,
        progress: _animationController,
      ),
      onPressed: () => _handleOnPressed(),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';


class CallPage extends StatelessWidget {
  const CallPage({super.key, required this.callID,required this.userName});

  final String callID;
  final String userName;

  @override
  Widget build(BuildContext context) {
    final userId = Random().nextInt(9999);

    return ZegoUIKitPrebuiltCall(
      appID:
          1653604596, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          '3bc34c1e3f15e13f8e7ac9467d2fd1fa5584f0e709dd547e6c54d2fe45b16d66', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userId.toString(),
      userName: userName,
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}

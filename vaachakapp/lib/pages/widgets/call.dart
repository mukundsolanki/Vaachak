// import 'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// class CallPage extends StatelessWidget {
//   const CallPage({Key? key, required this.callID}) : super(key: key);
//   final String callID;

//   @override
//   Widget build(BuildContext context) {
//     return ZegoUIKitPrebuiltCall(
//       appID: 1511202084, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
//       appSign: "2bb52911555aaf3cef7a7477a88f59b39c9459fd91ada7e0a064521df8841fd1", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
//       userID: 'user1',
//       userName: 'user_name1',
//       callID: callID,
//       // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
//       config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
//     );
//   }
// }
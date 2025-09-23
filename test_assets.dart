import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AssetTestScreen(),
    );
  }
}

class AssetTestScreen extends StatefulWidget {
  @override
  _AssetTestScreenState createState() => _AssetTestScreenState();
}

class _AssetTestScreenState extends State<AssetTestScreen> {
  List<String> testAssets = [
    'assets/images/hargeisa_cover.jpg',
    'assets/images/image/berbera.jpeg',
    'assets/images/image/borama.jpeg',
    'assets/images/image/burco.jpeg',
    'assets/images/image/erigabo.jpeg',
    'assets/images/image/Gabiley.jpeg',
    'assets/images/image/Hargeisa somaliland.jpeg',
  ];

  Map<String, bool> assetStatus = {};

  @override
  void initState() {
    super.initState();
    _testAssets();
  }

  Future<void> _testAssets() async {
    for (String asset in testAssets) {
      try {
        await rootBundle.load(asset);
        setState(() {
          assetStatus[asset] = true;
        });
        print('✅ Asset loaded successfully: $asset');
      } catch (e) {
        setState(() {
          assetStatus[asset] = false;
        });
        print('❌ Asset failed to load: $asset - Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Asset Test')),
      body: ListView.builder(
        itemCount: testAssets.length,
        itemBuilder: (context, index) {
          String asset = testAssets[index];
          bool? exists = assetStatus[asset];
          
          return ListTile(
            leading: exists == true 
              ? Icon(Icons.check_circle, color: Colors.green)
              : exists == false 
                ? Icon(Icons.error, color: Colors.red)
                : Icon(Icons.hourglass_empty, color: Colors.orange),
            title: Text(asset),
            subtitle: exists == true 
              ? Text('✅ Loaded successfully')
              : exists == false 
                ? Text('❌ Failed to load')
                : Text('⏳ Testing...'),
            trailing: exists == true 
              ? Container(
                  width: 50,
                  height: 50,
                  child: Image.asset(asset, fit: BoxFit.cover),
                )
              : null,
          );
        },
      ),
    );
  }
}

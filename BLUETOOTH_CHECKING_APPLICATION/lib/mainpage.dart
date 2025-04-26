import 'dart:convert';
import 'actionbtn.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _bluetooth = FlutterBluetoothSerial.instance;
  bool _bluetoothState = false;
  bool _isConnecting = false;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _deviceConnected;
  int times = 0;
  List dataList = [0,0,0,0];

  void _getDevices() async {
    var res = await _bluetooth.getBondedDevices();
    setState(() => _devices = res);
  }

  void _receiveData() {
  int? previousData1; // Store the previous value for the first data
  int? previousData2; // Store the previous value for the second data
  int? previousData3;
  int? previousData4;

  _connection?.input?.listen((event) {
    String data = String.fromCharCodes(event);
    print("data -> " + data);
    List<String> splitData = data.split(','); // Assuming values are separated by a comma

    if (splitData.length >= 2) {
      // Attempt to parse data, handling potential errors gracefully
      int newData1 = int.tryParse(splitData[1]) ?? 0; // Parse the first received data
      int newData2 = int.tryParse(splitData[2]) ?? 0; // Parse the second received data
      int newData3 = int.tryParse(splitData[3]) ?? 0; // Parse the first received data
      int newData4 = int.tryParse(splitData[4]) ?? 0;

      // Check for changes in either value (or initial reception)
      bool anyChange = previousData1 != newData1 || previousData2 != newData2 || previousData3 != newData3 || previousData4 != newData4;

      if (anyChange) {
        setState(() {
          dataList[0] = newData1;
          dataList[1] = newData2;
          dataList[2] = newData3;
          dataList[3] = newData4;
        });

        // Update previous values for future comparisons
        previousData1 = newData1;
        previousData2 = newData2;
        previousData3 = newData3;
        previousData4 = newData4;
      }
    } else {
      print('Error: Invalid data format (expected comma-separated values)');
    }
  });
}


  void _sendData(String data) {
    if (_connection?.isConnected ?? false) {
      _connection?.output.add(ascii.encode(data));
    }
  }

  void _requestPermission() async {
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
  }

  @override
  void initState() {
    super.initState();

    _requestPermission();

    _bluetooth.state.then((state) {
      setState(() => _bluetoothState = state.isEnabled);
    });

    _bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BluetoothState.STATE_OFF:
          setState(() => _bluetoothState = false);
          break;
        case BluetoothState.STATE_ON:
          setState(() => _bluetoothState = true);
          break;
        // case BluetoothState.STATE_TURNING_OFF:
        //   break;
        // case BluetoothState.STATE_TURNING_ON:
        //   break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flutter 💕 Arduino'),
      ),
      body: Column(
        children: [
          _controlBT(),
          _infoDevice(),
          Expanded(child: _listDevices()),
          Center(child: _receivedDataWidget()),
          // _inputSerial(),
          // _buttons(),
          
        ],
      ),
    );
  }

  Widget _receivedDataWidget() {
    

    return Column(
      children: dataList.map((e) => Text('$e')).toList(),
    );
      // child: Text('Received Data: $receivedData'));
  }

  Widget _controlBT() {
    return SwitchListTile(
      value: _bluetoothState,
      onChanged: (bool value) async {
        if (value) {
          await _bluetooth.requestEnable();
        } else {
          await _bluetooth.requestDisable();
        }
      },
      tileColor: Colors.black26,
      title: Text(
        _bluetoothState ? "Bluetooth on" : "Bluetooth off",
      ),
    );
  }

  Widget _infoDevice() {
    return ListTile(
      tileColor: Colors.black12,
      title: Text("connect to: ${_deviceConnected?.name ?? "device"}"),
      trailing: _connection?.isConnected ?? false
          ? TextButton(
              onPressed: () async {
                await _connection?.finish();
                setState(() => _deviceConnected = null);
              },
              child: const Text("disconnect"),
            )
          : TextButton(
              onPressed: _getDevices,
              child: const Text("view devices"),
            ),
    );
  }

  Widget _listDevices() {
    return _isConnecting
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  ...[
                    for (final device in _devices)
                      ListTile(
                        title: Text(device.name ?? device.address),
                        trailing: TextButton(
                          child: const Text('connect'),
                          onPressed: () async {
                            setState(() => _isConnecting = true);

                            _connection = await BluetoothConnection.toAddress(device.address);
                            _deviceConnected = device;
                            _devices = [];
                            _isConnecting = false;

                            _receiveData();

                            setState(() {});
                          },
                        ),
                      )
                  ]
                ],
              ),
            ),
          );
  }

  // Widget _inputSerial() {
  //   return ListTile(
  //     trailing: TextButton(
  //       child: const Text('reiniciar'),
  //       onPressed: () => setState(() => times = 0),
  //     ),
  //     title: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 16.0),
  //       child: Text(
  //         "Pulsador presionado (x$times)",
  //         style: const TextStyle(fontSize: 18.0),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buttons() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
  //     color: Colors.black12,
  //     child: Column(
  //       children: [
  //         const Text('Controles para LED', style: TextStyle(fontSize: 18.0)),
  //         const SizedBox(height: 16.0),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: ActionButton(
  //                 text: "Encender",
  //                 color: Colors.green,
  //                 onTap: () => _sendData("1"),
  //               ),
  //             ),
  //             const SizedBox(width: 8.0),
  //             Expanded(
  //               child: ActionButton(
  //                 color: Colors.red,
  //                 text: "Apagar",
  //                 onTap: () => _sendData("0"),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
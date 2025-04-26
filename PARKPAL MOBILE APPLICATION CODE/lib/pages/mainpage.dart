import 'dart:convert';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'parking.dart';
import 'slotWidget.dart';

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
  List dataList1 = [1, 0, 0];
  List dataList2 = [0, 0, 1];

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
      List<String> splitData =
          data.split(','); // Assuming values are separated by a comma

      if (splitData.length >= 2) {
        // Attempt to parse data, handling potential errors gracefully
        int newData1 =
            int.tryParse(splitData[1]) ?? 0; // Parse the first received data
        int newData2 =
            int.tryParse(splitData[2]) ?? 0; // Parse the second received data
        int newData3 =
            int.tryParse(splitData[3]) ?? 0; // Parse the first received data
        int newData4 = int.tryParse(splitData[4]) ?? 0;

        // Check for changes in either value (or initial reception)
        bool anyChange = previousData1 != newData1 ||
            previousData2 != newData2 ||
            previousData3 != newData3 ||
            previousData4 != newData4;

        if (anyChange) {
          setState(() {
            dataList1[2] = newData1;
            dataList1[1] = newData2;
            dataList2[1] = newData3;
            dataList2[0] = newData4;
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

    // Automatically connect to HC-05 device
    _connectToHC05();
  }

  void _connectToHC05() async {
    // Scan for devices
    List<BluetoothDevice> devices = await _bluetooth.getBondedDevices();

    // Find the HC-05 device
    BluetoothDevice? hc05Device = devices.firstWhere(
      (device) =>
          device.name ==
          'HC-05', // Replace 'HC-05' with the name of your HC-05 device
    );

    // If HC-05 device found, connect to it
    if (hc05Device != null) {
      _connection = await BluetoothConnection.toAddress(hc05Device.address);
      _deviceConnected = hc05Device;

      // Start receiving data
      _receiveData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Connect to Bluetooth'),
      ),
      body: Column(
        children: [
          _controlBT(),
          _infoDevice(),
          _receivedDataWidget(),
        ],
      ),
    );
  }

  Widget _receivedDataWidget() {
    var cnt = 0;
    for (var i in dataList1) {
      if (i == 0) {
        cnt += 1;
      }
    }

    for (var i in dataList2) {
      if (i == 0) {
        cnt += 1;
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Text('Select a Slot',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat Bold',
                  fontSize: 35)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
          child: Text('$cnt available slots',
              style: const TextStyle(
                  fontFamily: 'Montserrat ExtraLight',
                  fontSize: 16,
                  letterSpacing: 1.1,
                  color: Color.fromARGB(255, 135, 233, 248))),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: dataList1.map((e) => slotWidget(slot: e)).toList(),
            ),
            Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                        child: Image.asset('assets/images/arrow.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Image.asset('assets/images/arrow.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                        child: Image.asset('assets/images/arrow.png'),
                      ),
                    ],
                  ),
            Column(
              children: dataList2.map((e) => slotWidget(slot: e)).toList(),
            ),
          ],
        ),
      ],
    );
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
      tileColor: const Color.fromARGB(66, 255, 255, 255),
      title: Text(
        _bluetoothState ? "Bluetooth on" : "Bluetooth off",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _infoDevice() {
    return ListTile(
      tileColor: Color.fromARGB(41, 0, 238, 255),
      title: Text(
        "${_deviceConnected?.name ?? "No device connected"}",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      trailing: _connection?.isConnected ?? false
          ? TextButton(
              onPressed: () async {
                await _connection?.finish();
                setState(() => _deviceConnected = null);
              },
              child: const Text("disconnect"),
            )
          : TextButton(
              onPressed: _connectToHC05,
              child: const Text("connect"),
            ),
    );
  }

  Widget _listDevices() {
    return _isConnecting
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
              color: Color.fromARGB(255, 0, 0, 0),
              child: Column(
                children: [
                  ...[
                    for (final device in _devices)
                      ListTile(
                        title: Text(
                          device.name ?? device.address,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat Medium'),
                        ),
                        trailing: TextButton(
                          child: const Text(
                            'connect',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          onPressed: () async {
                            setState(() => _isConnecting = true);

                            _connection = await BluetoothConnection.toAddress(
                                device.address);
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
}

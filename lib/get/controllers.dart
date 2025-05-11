import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SliderController extends GetxController {
  var sliderValue = 50.0.obs;
  late IO.Socket socket;

  @override
  void onInit() {
    super.onInit();

    socket = IO.io('http://127.0.0.1:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print("✅ 已连接到 Python 后端");
    });

    socket.on('slider_update', (data) {
      sliderValue.value = data['value'];
    });
  }

  void updateValue(double newValue) {
    sliderValue.value = newValue;
    socket.emit('slider_change', {'value': newValue});
  }

  @override
  void onClose() {
    socket.dispose();
    super.onClose();
  }
}

class StringController extends GetxController {
  var stringValue = ''.obs;

  void updateString(String newString) {
    stringValue.value = newString;
  }
}

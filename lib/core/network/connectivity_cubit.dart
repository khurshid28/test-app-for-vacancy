import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ConnectivityStatus { connected, disconnected, checking }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  Timer? _timer;

  ConnectivityCubit() : super(ConnectivityStatus.connected) {
    checkConnectivity();
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      checkConnectivity();
    });
  }

  Future<void> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        emit(ConnectivityStatus.connected);
      } else {
        emit(ConnectivityStatus.disconnected);
      }
    } catch (_) {
      emit(ConnectivityStatus.disconnected);
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

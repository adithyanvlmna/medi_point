
import 'dart:async';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';

class ConnectivityWrapperWidget extends StatefulWidget {
  final Widget child;

  const ConnectivityWrapperWidget({super.key, required this.child});

  @override
  State<ConnectivityWrapperWidget> createState() =>
      _ConnectivityWrapperWidgetState();
}

class _ConnectivityWrapperWidgetState
    extends State<ConnectivityWrapperWidget> {
  bool isOffline = false;
  bool showOnlineMessage = false;
  late StreamSubscription<ConnectivityStatus> _subscription;

  @override
  void initState() {
    super.initState();

    // Initial connection check
    ConnectivityWrapper.instance.isConnected.then((connected) {
      setState(() {
        isOffline = !connected;
      });
    });

    // Listen for changes
    _subscription =
        ConnectivityWrapper.instance.onStatusChange.listen((status) {
      final currentlyOffline = status == ConnectivityStatus.DISCONNECTED;

      if (currentlyOffline != isOffline) {
        setState(() {
          isOffline = currentlyOffline;

          if (!currentlyOffline) {
            showOnlineMessage = true;
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  showOnlineMessage = false;
                });
              }
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shouldShowBanner = isOffline || showOnlineMessage;

    return ConnectivityAppWrapper(
      app: Stack(
        children: [
          ConnectivityWidgetWrapper(
            disableInteraction: true,
            offlineWidget: const SizedBox.shrink(), 
            child: widget.child,
          ),

          
          if (shouldShowBanner)
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedSlide(
                offset: Offset(0, 0),
                duration: const Duration(milliseconds: 300),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  color: isOffline ? Colors.red : Colors.green,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      isOffline ? 'No Internet Connection' : 'Back to Online',
                      style: const TextStyle(
                        
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
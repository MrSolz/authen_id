import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../application/log_out_controller.dart';

class LogOutPage extends ConsumerWidget {
  const LogOutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(logOutLoadingPageProvider).value ?? false;
    return Scaffold(
        body: Stack(
      children: [
        WebView(
          initialUrl: 'https://heracles.gobizdev.com/confirm_logout',
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) =>
              navigationDelegate(request, context, ref),
          onPageFinished: (finish) => onPageFinished(ref),
        ),
        loading
            ? Positioned.fill(
                child: Container(
                    color: Colors.black.withOpacity(0.2),
                    child: const Align(
                        alignment: Alignment.center, child: CircularProgressIndicator())))
            : Container(),
        Positioned(
            right: 10.0,
            top: 50.0,
            child: Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black87,
                        size: 20.0,
                      )),
                )
              ],
            )),
      ],
    ));
  }
}

import 'package:authen_id/src/features/authentication/application/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(signInLoadingPageProvider).value ?? false;
    return Scaffold(
        body: Stack(
      children: [
        WebView(
          initialUrl: 'https://heracles.gobizdev.com/login',
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) =>
              navigationDelegate(request, context, ref),
          onPageFinished: (finish) {
            ref.read(signInLoadingPageProvider.notifier).setLoading(false);
          },
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

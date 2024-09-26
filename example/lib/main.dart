// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:screenshot_ntv/screenshot_ntv.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS/macOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Screenshot_ntv Demo',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    Key? key,
  });

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final images = <Uint8List>[];
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // #docregion platform_features

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(
            PlatformWebViewControllerCreationParams());
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          // onHttpError: (HttpResponseError error) {
          //   debugPrint('Error occurred on page: ${error.response?.statusCode}');
          // },
          // onUrlChange: (UrlChange change) {
          //   debugPrint('url change to ${change.url}');
          // },
          // onHttpAuthRequest: (HttpAuthRequest request) {
          //   openDialog(request);
          // },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));

    // setBackgroundColor is not currently supported on macOS.
    if (kIsWeb || !Platform.isMacOS) {
      controller.setBackgroundColor(const Color(0x80000000));
    }

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await ScreenshotNtv.takeScreenshot();
          if (result != null) {
            images.add(result);
            setState(() {});
          }
        },
        child: const Icon(
          Icons.screenshot,
        ),
      ),
      body: images.isEmpty
          ? Center(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 800,
                    width: 300,
                    child: WebViewWidget(
                      controller: _controller,
                    ),
                  ),
                  const Text("not screenshot"),
                ],
              ),
            ))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Center(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(
                        images.length,
                        (index) => GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => ScreenshotView(
                                data: images[index],
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 15,
                                    color: Colors.black.withOpacity(0.15))
                              ],
                            ),
                            child: Image.memory(
                              images[index],
                              height: 250,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ScreenshotView extends StatelessWidget {
  const ScreenshotView({
    Key? key,
    required this.data,
  });

  final Uint8List data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Image.memory(data),
      ),
    );
  }
}

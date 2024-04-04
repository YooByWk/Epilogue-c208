import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class NaverLoginScreen extends StatefulWidget {
  @override
  _NaverLoginScreenState createState() => _NaverLoginScreenState();
}

class _NaverLoginScreenState extends State<NaverLoginScreen> {
  WebViewController? _webViewController;

  @override
  void initState() {
    final baseUrl = dotenv.env['API_URL'] ?? '';

    _webViewController = WebViewController()
      ..loadRequest(Uri.parse('$baseUrl/api/auth/oauth2/naver'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('네이버 로그인'),),
        body: WebViewWidget(controller: _webViewController!),
    );
  }
}

// class WebviewMainController extends GetxController {
//   static WebviewMainController get to => Get.find();
//
//   var controller = WebViewController()
//     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//     ..setBackgroundColor(const Color(0x00000000))
//     ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
// // Update loading bar.
//           },
//           onPageStarted: (String url) {},
//           onPageFinished: (String url) {},
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith("https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=YOUR_CLIENT_ID&redirect_uri=YOUR_REDIRECT_URI&state=YOUR_STATE")) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         )
//           ..loadRequest(Uri.parse('Your url'));
//         WebViewController getController() {
//   return controller;
//   }
// }
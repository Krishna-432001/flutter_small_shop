import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/markdown_widget.dart';

class PrivacyPolciyScreen extends StatelessWidget {
  const PrivacyPolciyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 1000,
          child: FutureBuilder(
            future: rootBundle.loadString('assets/markdown/privacy.md'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return MarkdownWidget(
                  data: snapshot.data!,
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
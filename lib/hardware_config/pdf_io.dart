import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class PdfApp extends StatelessWidget {
  final String path;
  const PdfApp({Key? key,required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PdfView(
      
      path: path);
  }
}
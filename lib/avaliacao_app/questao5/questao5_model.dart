import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'questao5_widget.dart' show Questao5Widget;
import 'package:flutter/material.dart';

class Questao5Model extends FlutterFlowModel<Questao5Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}

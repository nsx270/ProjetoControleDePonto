import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'registrar_widget.dart' show RegistrarWidget;
import 'package:flutter/material.dart';

class RegistrarModel extends FlutterFlowModel<RegistrarWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // State field(s) for VerificarEmail widget.
  FocusNode? verificarEmailFocusNode;
  TextEditingController? verificarEmailTextController;
  String? Function(BuildContext, String?)?
      verificarEmailTextControllerValidator;
  // State field(s) for Telefone widget.
  FocusNode? telefoneFocusNode;
  TextEditingController? telefoneTextController;
  String? Function(BuildContext, String?)? telefoneTextControllerValidator;
  // State field(s) for Senha widget.
  FocusNode? senhaFocusNode;
  TextEditingController? senhaTextController;
  late bool senhaVisibility;
  String? Function(BuildContext, String?)? senhaTextControllerValidator;
  // State field(s) for passwordConfirm widget.
  FocusNode? passwordConfirmFocusNode;
  TextEditingController? passwordConfirmTextController;
  late bool passwordConfirmVisibility;
  String? Function(BuildContext, String?)?
      passwordConfirmTextControllerValidator;

  @override
  void initState(BuildContext context) {
    senhaVisibility = false;
    passwordConfirmVisibility = false;
  }

  @override
  void dispose() {
    emailFocusNode?.dispose();
    emailTextController?.dispose();

    verificarEmailFocusNode?.dispose();
    verificarEmailTextController?.dispose();

    telefoneFocusNode?.dispose();
    telefoneTextController?.dispose();

    senhaFocusNode?.dispose();
    senhaTextController?.dispose();

    passwordConfirmFocusNode?.dispose();
    passwordConfirmTextController?.dispose();
  }
}

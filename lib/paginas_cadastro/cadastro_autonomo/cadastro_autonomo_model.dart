import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'cadastro_autonomo_widget.dart' show CadastroAutonomoWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastroAutonomoModel extends FlutterFlowModel<CadastroAutonomoWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Nome widget.
  FocusNode? nomeFocusNode;
  TextEditingController? nomeTextController;
  String? Function(BuildContext, String?)? nomeTextControllerValidator;
  // State field(s) for CPF widget.
  FocusNode? cpfFocusNode;
  TextEditingController? cpfTextController;
  final cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');
  String? Function(BuildContext, String?)? cpfTextControllerValidator;
  // State field(s) for CNPJ widget.
  FocusNode? cnpjFocusNode;
  TextEditingController? cnpjTextController;
  final cnpjMask = MaskTextInputFormatter(mask: '##.###.###/####-##');
  String? Function(BuildContext, String?)? cnpjTextControllerValidator;
  // State field(s) for Nasc widget.
  FocusNode? nascFocusNode;
  TextEditingController? nascTextController;
  final nascMask = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? nascTextControllerValidator;
  // State field(s) for Sexo widget.
  String? sexoValue;
  FormFieldController<String>? sexoValueController;
  // State field(s) for CEP widget.
  FocusNode? cepFocusNode;
  TextEditingController? cepTextController;
  final cepMask = MaskTextInputFormatter(mask: '#####-###');
  String? Function(BuildContext, String?)? cepTextControllerValidator;
  // State field(s) for UF widget.
  String? ufValue;
  FormFieldController<String>? ufValueController;
  // State field(s) for Cidade widget.
  FocusNode? cidadeFocusNode;
  TextEditingController? cidadeTextController;
  String? Function(BuildContext, String?)? cidadeTextControllerValidator;
  // State field(s) for Endereco widget.
  FocusNode? enderecoFocusNode;
  TextEditingController? enderecoTextController;
  String? Function(BuildContext, String?)? enderecoTextControllerValidator;
  // State field(s) for numero widget.
  FocusNode? numeroFocusNode;
  TextEditingController? numeroTextController;
  String? Function(BuildContext, String?)? numeroTextControllerValidator;
  // State field(s) for complemento widget.
  FocusNode? complementoFocusNode;
  TextEditingController? complementoTextController;
  String? Function(BuildContext, String?)? complementoTextControllerValidator;
  // State field(s) for PontodeREF widget.
  FocusNode? pontodeREFFocusNode;
  TextEditingController? pontodeREFTextController;
  String? Function(BuildContext, String?)? pontodeREFTextControllerValidator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nomeFocusNode?.dispose();
    nomeTextController?.dispose();

    cpfFocusNode?.dispose();
    cpfTextController?.dispose();

    cnpjFocusNode?.dispose();
    cnpjTextController?.dispose();

    nascFocusNode?.dispose();
    nascTextController?.dispose();

    cepFocusNode?.dispose();
    cepTextController?.dispose();

    cidadeFocusNode?.dispose();
    cidadeTextController?.dispose();

    enderecoFocusNode?.dispose();
    enderecoTextController?.dispose();

    numeroFocusNode?.dispose();
    numeroTextController?.dispose();

    complementoFocusNode?.dispose();
    complementoTextController?.dispose();

    pontodeREFFocusNode?.dispose();
    pontodeREFTextController?.dispose();
  }
}

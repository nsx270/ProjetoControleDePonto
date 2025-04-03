// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BancoDeDadosStruct extends BaseStruct {
  BancoDeDadosStruct({
    List<String>? nome,
    int? cpf,
    List<int>? telefone,
    List<String>? eMail,
    List<String>? senha,
    int? cnpj,
    String? endereco,
  })  : _nome = nome,
        _cpf = cpf,
        _telefone = telefone,
        _eMail = eMail,
        _senha = senha,
        _cnpj = cnpj,
        _endereco = endereco;

  // "Nome" field.
  List<String>? _nome;
  List<String> get nome => _nome ?? const [];
  set nome(List<String>? val) => _nome = val;

  void updateNome(Function(List<String>) updateFn) {
    updateFn(_nome ??= []);
  }

  bool hasNome() => _nome != null;

  // "CPF" field.
  int? _cpf;
  int get cpf => _cpf ?? 0;
  set cpf(int? val) => _cpf = val;

  void incrementCpf(int amount) => cpf = cpf + amount;

  bool hasCpf() => _cpf != null;

  // "Telefone" field.
  List<int>? _telefone;
  List<int> get telefone => _telefone ?? const [];
  set telefone(List<int>? val) => _telefone = val;

  void updateTelefone(Function(List<int>) updateFn) {
    updateFn(_telefone ??= []);
  }

  bool hasTelefone() => _telefone != null;

  // "E-mail" field.
  List<String>? _eMail;
  List<String> get eMail => _eMail ?? const [];
  set eMail(List<String>? val) => _eMail = val;

  void updateEMail(Function(List<String>) updateFn) {
    updateFn(_eMail ??= []);
  }

  bool hasEMail() => _eMail != null;

  // "Senha" field.
  List<String>? _senha;
  List<String> get senha => _senha ?? const [];
  set senha(List<String>? val) => _senha = val;

  void updateSenha(Function(List<String>) updateFn) {
    updateFn(_senha ??= []);
  }

  bool hasSenha() => _senha != null;

  // "CNPJ" field.
  int? _cnpj;
  int get cnpj => _cnpj ?? 0;
  set cnpj(int? val) => _cnpj = val;

  void incrementCnpj(int amount) => cnpj = cnpj + amount;

  bool hasCnpj() => _cnpj != null;

  // "Endereco" field.
  String? _endereco;
  String get endereco => _endereco ?? '';
  set endereco(String? val) => _endereco = val;

  bool hasEndereco() => _endereco != null;

  static BancoDeDadosStruct fromMap(Map<String, dynamic> data) =>
      BancoDeDadosStruct(
        nome: getDataList(data['Nome']),
        cpf: castToType<int>(data['CPF']),
        telefone: getDataList(data['Telefone']),
        eMail: getDataList(data['E-mail']),
        senha: getDataList(data['Senha']),
        cnpj: castToType<int>(data['CNPJ']),
        endereco: data['Endereco'] as String?,
      );

  static BancoDeDadosStruct? maybeFromMap(dynamic data) => data is Map
      ? BancoDeDadosStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Nome': _nome,
        'CPF': _cpf,
        'Telefone': _telefone,
        'E-mail': _eMail,
        'Senha': _senha,
        'CNPJ': _cnpj,
        'Endereco': _endereco,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Nome': serializeParam(
          _nome,
          ParamType.String,
          isList: true,
        ),
        'CPF': serializeParam(
          _cpf,
          ParamType.int,
        ),
        'Telefone': serializeParam(
          _telefone,
          ParamType.int,
          isList: true,
        ),
        'E-mail': serializeParam(
          _eMail,
          ParamType.String,
          isList: true,
        ),
        'Senha': serializeParam(
          _senha,
          ParamType.String,
          isList: true,
        ),
        'CNPJ': serializeParam(
          _cnpj,
          ParamType.int,
        ),
        'Endereco': serializeParam(
          _endereco,
          ParamType.String,
        ),
      }.withoutNulls;

  static BancoDeDadosStruct fromSerializableMap(Map<String, dynamic> data) =>
      BancoDeDadosStruct(
        nome: deserializeParam<String>(
          data['Nome'],
          ParamType.String,
          true,
        ),
        cpf: deserializeParam(
          data['CPF'],
          ParamType.int,
          false,
        ),
        telefone: deserializeParam<int>(
          data['Telefone'],
          ParamType.int,
          true,
        ),
        eMail: deserializeParam<String>(
          data['E-mail'],
          ParamType.String,
          true,
        ),
        senha: deserializeParam<String>(
          data['Senha'],
          ParamType.String,
          true,
        ),
        cnpj: deserializeParam(
          data['CNPJ'],
          ParamType.int,
          false,
        ),
        endereco: deserializeParam(
          data['Endereco'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'BancoDeDadosStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is BancoDeDadosStruct &&
        listEquality.equals(nome, other.nome) &&
        cpf == other.cpf &&
        listEquality.equals(telefone, other.telefone) &&
        listEquality.equals(eMail, other.eMail) &&
        listEquality.equals(senha, other.senha) &&
        cnpj == other.cnpj &&
        endereco == other.endereco;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([nome, cpf, telefone, eMail, senha, cnpj, endereco]);
}

BancoDeDadosStruct createBancoDeDadosStruct({
  int? cpf,
  int? cnpj,
  String? endereco,
}) =>
    BancoDeDadosStruct(
      cpf: cpf,
      cnpj: cnpj,
      endereco: endereco,
    );

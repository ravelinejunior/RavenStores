import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ravelinestores/models/cep_address.dart';

const token = '61569c12485248c4fa57d43772fa87c2';

class CepAbertoService {
  /* 
    requisições usando a lib DIO
    1 -- eliminar todos os pontos e traços do cep 
    2 -- registrar token no EndPoint para buscar dados no header
    3 -- utilizar o GET para recuperar o endpoint com o header
    4 -- especificar tipo de dados recuperados do get
    5 -- declarar o response como dio map e especificar o tipo do map como string e dynamic
   */

  Future<CepAddress> getAddressFromCep(String cep) async {
    final cleanCep = cep.replaceAll(".", "").replaceAll("-", "");
    final endPoint = "https://www.cepaberto.com/api/v3/cep?cep=${cleanCep}";

    final Dio dio = Dio();
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try {
      final response = await dio.get<Map<String, dynamic>>(endPoint);
      if (response.data.isEmpty) return Future.error("Cep Inválido");

      final CepAddress address = CepAddress.fromMap(response.data);
      return address;
    } on DioError catch (e) {
      return Future.error("Erro ao buscar Cep ${e.error}");
    }
  }
}

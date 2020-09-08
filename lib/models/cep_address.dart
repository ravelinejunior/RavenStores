class CepAddress {
  final double altitude;
  final double latitude;
  final double longitude;
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final Cidade cidade;
  final Estado estado;

  /* 
    1 - pegar o mapa e transforma-lo em um objeto do tipo cep
    2 - utilizando o from map para transformar em objeto tipo map e recuperar um objeto
    

   */

  CepAddress.fromMap(Map<String, dynamic> map)
      : altitude = map['altitude'] as double,
        latitude = double.tryParse(map['latitude'] as String),
        longitude = double.tryParse(map['longitude'] as String),
        cep = map['cep'] as String,
        logradouro = map['logradouro'] as String,
        complemento = map['complemento'] as String,
        bairro = map['bairro'] as String,
        cidade = Cidade.fromMap(map['cidade'] as Map<String, dynamic>),
        estado = Estado.fromMap(map['estado'] as Map<String, dynamic>);
}

class Cidade {
  final int ddd;
  final String ibge;
  final String nome;

  Cidade.fromMap(Map<String, dynamic> map)
      : ddd = map['ddd'] as int,
        ibge = map['ibge'] as String,
        nome = map['nome'] as String;
}

class Estado {
  final String sigla;

  Estado.fromMap(Map<String, dynamic> map) : sigla = map['sigla'] as String;
}

class MileageRecord {
  final int id;  // Adicionado o campo id
  final String mileage;
  final String driver;
  final String destination;
  final String photoPath;

  MileageRecord({
    required this.id,  // Agora o id é obrigatório no construtor
    required this.mileage,
    required this.driver,
    required this.destination,
    required this.photoPath,
  });

  // Converte o objeto para um mapa para ser armazenado no banco de dados
  Map<String, dynamic> toMap() {
    return {
      'id': id,  // Inclui o id no mapa
      'mileage': mileage,
      'driver': driver,
      'destination': destination,
      'photoPath': photoPath,
    };
  }

  // Construtor de fábrica para criar uma instância a partir de um mapa do banco de dados
  factory MileageRecord.fromMap(Map<String, dynamic> map) {
    return MileageRecord(
      id: map['id'],  // Obtém o id do mapa
      mileage: map['mileage'],
      driver: map['driver'],
      destination: map['destination'],
      photoPath: map['photoPath'],
    );
  }
}


class CargaModel{

  final String carga;
  final bool value;

  const CargaModel._({
    required this.carga,
    required this.value,
  });

  static const vacio = CargaModel._(
    carga: "Vacio", 
    value: false
  );

  static const lleno = CargaModel._(
    carga: "Lleno", 
    value: true
  );

  static const cargaItems = [
    vacio,
    lleno
  ];

} 
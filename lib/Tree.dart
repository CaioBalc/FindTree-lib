class Tree {
  final int id;
  final String name;
  final String botanicalDescription;
  final String reproductiveBiology;
  final String fruiting;
  final String dispersion;
  final String naturalOccurrence;
  final String map;
  final String ecologicalAspects;
  final String naturalRegeneration;
  final String utilization;
  final String food;
  final String nutritionalData;
  final String consumptionForms;
  final String bioenergyAndComposition;
  final String bioproductsPotential;
  final String bioactivity;
  final String landscaping;
  final String nurseryCultivation;
  final String seedHarvestAndBeneficiation;
  final String seedlingProduction;
  final String transplanting;
  final String specialCare;
  final String water;
  final String soils;
  final List<Image> images;

  Tree({
    required this.id,
    required this.name,
    required this.botanicalDescription,
    required this.reproductiveBiology,
    required this.fruiting,
    required this.dispersion,
    required this.naturalOccurrence,
    required this.map,
    required this.ecologicalAspects,
    required this.naturalRegeneration,
    required this.utilization,
    required this.food,
    required this.nutritionalData,
    required this.consumptionForms,
    required this.bioenergyAndComposition,
    required this.bioproductsPotential,
    required this.bioactivity,
    required this.landscaping,
    required this.nurseryCultivation,
    required this.seedHarvestAndBeneficiation,
    required this.seedlingProduction,
    required this.transplanting,
    required this.specialCare,
    required this.water,
    required this.soils,
    required this.images,
  });

  factory Tree.fromJson(Map<String, dynamic> json) {
    return Tree(
      id: json['id'],
      name: json['nome_arvore'],
      botanicalDescription: json['descricao_botanica'],
      reproductiveBiology: json['biologia_reprodutiva'],
      fruiting: json['frutificacao'],
      dispersion: json['dispersao'],
      naturalOccurrence: json['ocorrencia_natural'],
      map: json['mapa'],
      ecologicalAspects: json['aspectos_ecologicos'],
      naturalRegeneration: json['regeneracao_natural'],
      utilization: json['aproveitamento'],
      food: json['alimentacao'],
      nutritionalData: json['dados_nutricionais'],
      consumptionForms: json['formas_consumo'],
      bioenergyAndComposition: json['biotec_energ'],
      bioproductsPotential: json['poten_bioprodutos'],
      bioactivity: json['bioatividade'],
      landscaping: json['paisagismo'],
      nurseryCultivation: json['cultivo_viveiro'],
      seedHarvestAndBeneficiation: json['colheita_benef_semente'],
      seedlingProduction: json['producao_mudas'],
      transplanting: json['transplante'],
      specialCare: json['cuidados_especiais'],
      water: json['agua'],
      soils: json['solos'],
      images: (json['imagens'] as List)
          .map((imageJson) => Image.fromJson(imageJson))
          .toList(),
    );
  }
}

class Image {
  final int id;
  final String image;
  final String description;
  final int treeId;

  Image({
    required this.id,
    required this.image,
    required this.description,
    required this.treeId,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      image: json['imagem'],
      description: json['descricao'],
      treeId: json['arvore_id'],
    );
  }
}
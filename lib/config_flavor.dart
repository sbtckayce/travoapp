enum Flavor { dev, prod, stag }

class ConfigFlavor {
  final Flavor flavor;
  final BaseFlavorValue values;
  static ConfigFlavor? instance;

  factory ConfigFlavor({required BaseFlavorValue values}) {
    instance ??= ConfigFlavor._internal(values.flavor(), values);
    return instance!;
  }
  ConfigFlavor._internal(this.flavor, this.values);
}

abstract class BaseFlavorValue {
  String getContent();
  Flavor flavor();
}

class FlavorValueDev extends BaseFlavorValue {
  @override
  Flavor flavor() {
    return Flavor.dev;
  }

  @override
  String getContent() {
    return "This is Dev";
  }
}

class FlavorValueProd extends BaseFlavorValue {
  @override
  Flavor flavor() {
    return Flavor.prod;
  }

  @override
  String getContent() {
    return "This is Product";
  }
}

class FlavorValueStag extends BaseFlavorValue {
  @override
  Flavor flavor() {
    return Flavor.stag;
  }

  @override
  String getContent() {
    return "This is Stagging";
  }
}

class Service {
  final int id;
  final String name;

  Service({
    this.id,
    this.name,
  });

  static List<Service> services = [
    Service(id: 1, name: "parking"),
    Service(id: 2, name: "wifi"),
    Service(id: 3, name: "Air conditioning"),
    Service(id: 4, name: "Animal"),
    Service(id: 5, name: "spa")
  ];
}

class Guide {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String? route;

  Guide({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    this.route,
  });
}

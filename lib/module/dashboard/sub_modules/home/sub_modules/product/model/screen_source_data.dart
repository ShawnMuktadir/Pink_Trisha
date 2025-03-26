class ScreenSourceData {
  final int? sourceId;
  final String? sourceName;
  final String? slug;
  final SourceType sourceType;

  ScreenSourceData(
      {this.sourceId, this.sourceName, this.slug, required this.sourceType});
}

enum SourceType { category, brand, search, all, filter }

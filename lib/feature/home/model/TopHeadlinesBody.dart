class TopHeadlinesBody {
  final String country;
  final String? category;
  final String? sources;
  final String? q;
  final int? pageSize;
  final int? page;

  const TopHeadlinesBody({
    this.country = 'us',
    this.category,
    this.sources,
    this.q,
    this.pageSize,
    this.page,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'category': category,
      'sources': sources,
      'q': q,
      'pageSize': pageSize,
      'page': page,
    };
  }

  factory TopHeadlinesBody.fromMap(Map<String, dynamic> map) {
    return TopHeadlinesBody(
      country: map['country'] as String,
      category: map['category'] != null ? map['category'] as String : null,
      sources: map['sources'] != null ? map['sources'] as String : null,
      q: map['q'] != null ? map['q'] as String : null,
      pageSize: map['pageSize'] != null ? map['pageSize'] as int : null,
      page: map['page'] != null ? map['page'] as int : null,
    );
  }

  TopHeadlinesBody copyWith({
    String? country,
    String? category,
    String? sources,
    String? q,
    int? pageSize,
    int? page,
  }) {
    return TopHeadlinesBody(
      country: country ?? this.country,
      category: category ?? this.category,
      sources: sources ?? this.sources,
      q: q ?? this.q,
      pageSize: pageSize ?? this.pageSize,
      page: page ?? this.page,
    );
  }

  @override
  String toString() {
    return 'TopHeadlinesBody(country: $country, category: $category, sources: $sources, q: $q, pageSize: $pageSize, page: $page)';
  }

  @override
  bool operator ==(covariant TopHeadlinesBody other) {
    if (identical(this, other)) return true;

    return other.country == country &&
        other.category == category &&
        other.sources == sources &&
        other.q == q &&
        other.pageSize == pageSize &&
        other.page == page;
  }

  @override
  int get hashCode {
    return country.hashCode ^
        category.hashCode ^
        sources.hashCode ^
        q.hashCode ^
        pageSize.hashCode ^
        page.hashCode;
  }
}

class PagedModel<T> {
  PagedModel({
    this.content,
    this.totalElements,
    this.last,
    this.totalPages,
    this.first,
    this.size,
    this.number,
    this.numberOfElements,
    this.empty,
  });

  List<T>? content;
  int? totalElements;
  bool? last;
  int? totalPages;
  bool? first;
  int? size;
  int? number;
  int? numberOfElements;
  bool? empty;

  factory PagedModel.fromJson(Map<String, dynamic> json, T Function(Map) contentMap) => PagedModel(
        content: List<T>.from(json["content"].map((x) => contentMap(x))),
        totalElements: json["totalElements"],
        last: json["last"],
        totalPages: json["totalPages"],
        first: json["first"],
        size: json["size"],
        number: json["number"],
        numberOfElements: json["numberOfElements"],
        empty: json["empty"],
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content!.map((dynamic x) => x.toJson())),
        "totalElements": totalElements,
        "last": last,
        "totalPages": totalPages,
        "first": first,
        "size": size,
        "number": number,
        "numberOfElements": numberOfElements,
        "empty": empty,
      };
}
import 'dart:convert';

PaginationModel paginationModelFromJson(String str) => PaginationModel.fromJson(json.decode(str));

String paginationModelToJson(PaginationModel data) => json.encode(data.toJson());

class PaginationModel {
  PaginationModel({
    required this.next,
    required this.previous,
    required this.first,
    required this.last,
    required this.paginationMessage,
  });

  First next;
  First previous;
  First first;
  Last last;
  String paginationMessage;

  factory PaginationModel.fromJson(Map<String, dynamic> json) => PaginationModel(
    next: First.fromJson(json["next"]),
    previous: First.fromJson(json["previous"]),
    first: First.fromJson(json["first"]),
    last: Last.fromJson(json["last"]),
    paginationMessage: json["pagination_message"],
  );

  Map<String, dynamic> toJson() => {
    "next": next.toJson(),
    "previous": previous.toJson(),
    "first": first.toJson(),
    "last": last.toJson(),
    "pagination_message": paginationMessage,
  };
}

class First {
  First();

  factory First.fromJson(Map<String, dynamic> json) => First(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Last {
  Last({
    required this.page,
    required this.limit,
  });

  int page;
  int limit;

  factory Last.fromJson(Map<String, dynamic> json) => Last(
    page: json["page"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
  };
}

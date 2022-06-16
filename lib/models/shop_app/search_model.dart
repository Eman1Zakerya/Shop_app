class SearchModel
{
  bool? status;
  String? message;
  Data? data;

  SearchModel.fromJson(Map<String,dynamic>json)
 {
   status = json['status'];
   message = json['message'];
    data = Data.fromJson(json['data']);
 }
}

class Data
{
   int? currentPage;
   String? firstPageUrl;
   int? from;
   int? lastPage;
   String? lastPageUrl;
   String? nextPageUrl;
   String? path;
   int? perPage;
   String? prevPageUrl;
   int? to;
   int? total;
   List<Products> data =[];

   Data.fromJson(Map<String,dynamic>json)
   {
     currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(Products.fromJson(element));
    });
    
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
   }
}



class Products
{
  int?id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Products.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];

  }
}
class ReceiveinModel {
    ReceiveinModel({
        this.id,
        this.date,
        this.trader_id,
        this.quality,
        this.buying_price,
        this.created_at,
        this.quantity,
        this.source,
        this.crop_id,
        this.warehouse_id,
        this.village_id,
        this.ward_id,
        this.district_id,
        this.region_id,
        this.origin_market,
        this.origin_warehouse,
        this.cess_payment,
        this.updated_at
    });

    int id;
    String date;
    int trader_id;
    String quality;
    String buying_price;
    String created_at;
    int quantity;
    String source;
    int crop_id;
    int warehouse_id;
    int village_id;
    int ward_id;
    int district_id;
    int region_id;
    String origin_warehouse;
    String  origin_market;
    int cess_payment;
    String updated_at



    factory ReceiveinModel.fromJson(Map<String, dynamic> json) => ReceiveinModel(
        id: json["id"],
        date: json["date"],
        trader_id: json["user_id"],
        quality: json["quality"],
        buying_price: json["buying_price"],
        created_at: json["created_at"],
        quantity:json["quantity"],
        source: json["source"],
        crop_id: json["crop_id"],
        warehouse_id: json["warehouse_id"],
        village_id: json["village_id"],
        ward_id: json["ward_id"],
        district_id: json["district_id"],
        region_id: json["region_id"],
        origin_warehouse: json["origin_warehouse"],
        cess_payment: json["cess_payment"],
        updated_at: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "user_id": trader_id,
        "quality": quality,
        "buying_price": buying_price,
        "created_at": created_at,
        "quantity": quantity,
        "source": source,
        "crop_id": crop_id,
        "warehouse_id": warehouse_id,
        "village_id": village_id,
        "ward_id": ward_id,
        "district_id": district_id,
        "region_id": region_id,
        "origin_warehouse": origin_warehouse,
        "cess_payment": cess_payment,
        "updated_at": updated_at,
    };
}
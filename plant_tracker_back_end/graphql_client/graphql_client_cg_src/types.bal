public type Plant record {
    int? plant_id?;
    string? lighting_condition?;
    string? origin?;
    string? description?;
    string? scientific_name?;
    string? growing_speed?;
    string? record_type?;
    string? date_added?;
    int? category_id?;
    string? photo_url?;
    string? common_name?;
    string? family?;
    string? care_instructions?;
    string? substrate?;
};

public type AddPlantResponse record {|
    map<json?> __extensions?;
    record {|
        int? plant_id;
    |}? create_plant;
|};

public type GetPlantListResponse record {|
    map<json?> __extensions?;
    record {|
        int? plant_id;
        string? common_name;
        string? scientific_name;
        string? family;
        string? description;
        string? care_instructions;
        string? photo_url;
        string? origin;
        string? lighting_condition;
        string? substrate;
        string? growing_speed;
        record {|
            int? category_id;
            string? category_name;
            string? description;
        |}? category;
    |}[] plants;
|};

public type GetPlantByCategoryResponse record {|
    map<json?> __extensions?;
    record {|
        int? plant_id;
        string? common_name;
        string? scientific_name;
        string? family;
        string? description;
        string? care_instructions;
        string? photo_url;
        string? origin;
        string? lighting_condition;
        string? substrate;
        string? growing_speed;
        record {|
            int? category_id;
            string? category_name;
            string? description;
        |}? category;
    |}[]? plants_by_category;
|};

public type GetPersonResponse record {|
    map<json?> __extensions?;
    record {|
        int? id;
        string? full_name;
        string? asgardeo_id;
        string? jwt_sub_id;
        string? jwt_email;
        string? digital_id;
        string? email;
        string? created;
        string? updated;
    |}? person_by_digital_id;
|};

import ballerina/http;
import ballerina/graphql;
import ballerina/log;


public function initClientConfig() returns ConnectionConfig{
    ConnectionConfig _clientConig = {};
    if (GLOBAL_DATA_USE_AUTH) {
        _clientConig.oauth2ClientCredentialsGrantConfig =  {
            tokenUrl: CHOREO_TOKEN_URL,
            clientId:GLOBAL_DATA_CLIENT_ID,
            clientSecret:GLOBAL_DATA_CLIENT_SECRET
        };
    } else { 
        _clientConig = {};
    }
    return _clientConig;
}


final GraphqlClient globalDataClient = check new (GLOBAL_DATA_API_URL,
    config = initClientConfig()
);

# A service representing a network-accessible API
# bound to port `9091`.
@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service / on new http:Listener(9095) {

    # A resource for generating greetings
    # + name - the input string name
    # + return - string name with hello message or error
    resource function get greeting(string name) returns string|error {
        // Send a response back to the caller.
        if name is "" {
            return error("name should not be empty!");
        }
        return "Hello, " + name;
    }

    resource function get person(string digital_id) returns Person|error {

        GetPersonResponse|graphql:ClientError getPersonResponse = globalDataClient->getPerson(digital_id);
        if(getPersonResponse is GetPersonResponse) {
            Person|error person_record = getPersonResponse.person_by_digital_id.cloneWithType(Person);
            if(person_record is Person) {
                return person_record;
            } else {
                log:printError("Error while processing Application record received1", person_record);
                return error("Error while processing Person record received2: " + person_record.message() + 
                    ":: Detail: " + person_record.detail().toString());
            }
        } else {
            log:printError("Error while fetching person records application3", getPersonResponse);
            return error("Error while fetching person records application4: " + getPersonResponse.message() + 
                ":: Detail: " + getPersonResponse.detail().toString());
        }
    }


    resource function post  create_plant(@http:Payload Plant plant) returns Plant|error {
        AddPlantResponse|graphql:ClientError createPlantResponse = globalDataClient->addPlant(plant);
        if(createPlantResponse is AddPlantResponse) {
            Plant|error plant_record = createPlantResponse.create_plant.cloneWithType(Plant);
            if(plant_record is Plant) {
                return plant_record;
            } else {
                log:printError("Error while processing Application record received", plant_record);
                return error("Error while processing Application record received: " + plant_record.message() + 
                    ":: Detail: " + plant_record.detail().toString());
            }
        } else {
            log:printError("Error while creating application", createPlantResponse);
            return error("Error while creating application: " + createPlantResponse.message() + 
                ":: Detail: " + createPlantResponse.detail().toString());
        }
    }

    resource function get plants() returns Plant[]|error {
        GetPlantListResponse|graphql:ClientError getPlantListResponse = globalDataClient->getPlantList();
        if(getPlantListResponse is GetPlantListResponse) {
            Plant[] plantList = [];
            foreach var plant_record  in getPlantListResponse.plants {
                Plant|error plantRecord  = plant_record.cloneWithType(Plant);
                if(plantRecord is Plant) {
                    plantList.push(plantRecord);
                } else {
                    log:printError("Error while processing Application record received",plantRecord);
                    return error("Error while processing Application record received: " + plantRecord.message() + 
                        ":: Detail: " + plantRecord.detail().toString());
                }
            }

            return plantList;
            
        } else {
            log:printError("Error while getting application", getPlantListResponse );
            return error("Error while getting application: " + getPlantListResponse.message() + 
                ":: Detail: " + getPlantListResponse.detail().toString());
        }
    }
    
    resource function get plants_by_category/[int category_id]() returns Plant[]|error {
        GetPlantByCategoryResponse|graphql:ClientError getPlantByCategoryResponse = globalDataClient->getPlantByCategory(category_id);
        if(getPlantByCategoryResponse is GetPlantByCategoryResponse) {
            Plant[] plantList = [];
            foreach var plant_record  in getPlantByCategoryResponse.plants_by_category {
                Plant|error plantRecord  = plant_record.cloneWithType(Plant);
                if(plantRecord is Plant) {
                    plantList.push(plantRecord);
                } else {
                    log:printError("Error while processing Application record received",plantRecord);
                    return error("Error while processing Application record received: " + plantRecord.message() + 
                        ":: Detail: " + plantRecord.detail().toString());
                }
            }

            return plantList;
        } else {
            log:printError("Error while creating application", getPlantByCategoryResponse);
            return error("Error while creating application: " + getPlantByCategoryResponse.message() + 
                ":: Detail: " + getPlantByCategoryResponse.detail().toString());
        }
    }

}

import ballerina/graphql;

public isolated client class GraphqlClient {
    final graphql:Client graphqlClient;
    public isolated function init(string serviceUrl, ConnectionConfig config = {}) returns graphql:ClientError? {
        graphql:ClientConfiguration graphqlClientConfig = {auth: config.oauth2ClientCredentialsGrantConfig, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                graphqlClientConfig.http1Settings = {...settings};
            }
            if config.cache is graphql:CacheConfig {
                graphqlClientConfig.cache = check config.cache.ensureType(graphql:CacheConfig);
            }
            if config.responseLimits is graphql:ResponseLimitConfigs {
                graphqlClientConfig.responseLimits = check config.responseLimits.ensureType(graphql:ResponseLimitConfigs);
            }
            if config.secureSocket is graphql:ClientSecureSocket {
                graphqlClientConfig.secureSocket = check config.secureSocket.ensureType(graphql:ClientSecureSocket);
            }
            if config.proxy is graphql:ProxyConfig {
                graphqlClientConfig.proxy = check config.proxy.ensureType(graphql:ProxyConfig);
            }
        } on fail var e {
            return <graphql:ClientError>error("GraphQL Client Error", e, body = ());
        }
        graphql:Client clientEp = check new (serviceUrl, graphqlClientConfig);
        self.graphqlClient = clientEp;
    }

     remote isolated function addPlant(Plant plant) returns AddPlantResponse|graphql:ClientError {
        string query = string `mutation addPlant($plant:Plant!) {create_plant(plant:$plant) {plant_id}}`;
        map<anydata> variables = {"plant": plant};
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables);
        return <AddPlantResponse> check performDataBinding(graphqlResponse, AddPlantResponse);
    }
    remote isolated function getPlantList() returns GetPlantListResponse|graphql:ClientError {
        string query = string `query getPlantList {plants {plant_id common_name scientific_name family description care_instructions photo_url origin lighting_condition substrate growing_speed category {category_id category_name description}}}`;
        map<anydata> variables = {};
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables);
        return <GetPlantListResponse> check performDataBinding(graphqlResponse, GetPlantListResponse);
    }
    remote isolated function getPlantByCategory(int category_id) returns GetPlantByCategoryResponse|graphql:ClientError {
        string query = string `query getPlantByCategory($category_id:Int!) {plants_by_category(category_id:$category_id) {plant_id common_name scientific_name family description care_instructions photo_url origin lighting_condition substrate growing_speed category {category_id category_name description}}}`;
        map<anydata> variables = {"category_id": category_id};
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables);
        return <GetPlantByCategoryResponse> check performDataBinding(graphqlResponse, GetPlantByCategoryResponse);
    }
    remote isolated function getPerson(string id) returns GetPersonResponse|graphql:ClientError {
        string query = string `query getPerson($id:String!) {person_by_digital_id(id:$id) {id full_name asgardeo_id jwt_sub_id jwt_email digital_id email created updated}}`;
        map<anydata> variables = {"id": id};
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables);
        return <GetPersonResponse> check performDataBinding(graphqlResponse, GetPersonResponse);
    }
}

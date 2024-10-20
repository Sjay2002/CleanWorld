import ballerina/http;

service /events on new http:Listener(8080) {

    resource function get events(http:Caller caller, http:Request req) returns error? {
        json events = [
            { date: "2024-10-10", location: "City Park", name: "Park Cleanup" },
            { date: "2024-10-15", location: "Beachside", name: "Beach Cleanup" },
            { date: "2024-10-20", location: "Downtown", name: "Downtown Cleanup" }
        ];

        check caller->respond(events);
    }
}

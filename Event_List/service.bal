import ballerina/http;

// Define a service to return event data.
service /events on new http:Listener(8080) {

    resource function get events(http:Caller caller, http:Request req) returns error? {
        // Dummy event data (In real-world apps, you can fetch this from a database)
        json events = [
            { date: "2024-10-10", location: "City Park", name: "Park Cleanup" },
            { date: "2024-10-15", location: "Beachside", name: "Beach Cleanup" },
            { date: "2024-10-20", location: "Downtown", name: "Downtown Cleanup" }
        ];

        // Send JSON response
        check caller->respond(events);
    }
}

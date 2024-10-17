import ballerina/http;
import ballerinax/mysql;

// Initialize MySQL client
mysql:Client dbClient = check new (host = "localhost", 
    user = "Local", 
    password = "Mnk#2001", 
    database = "MySQL", 
    port = 3306);

service / on new http:Listener(8080) {
    
    // Login resource
    resource function post login(http:Caller caller, http:Request req) returns error? {
        // Get the JSON payload from the request
        json payload = check req.getJsonPayload();

        // Safely retrieve username and password from JSON
        string username = check payload["username"].toString();
        string password = check payload["password"].toString();

        // Handle null or invalid input
        if username == "" || password == "" {
            check caller->respond({ status: "failure", message: "Invalid input" });
            return;
        }

        // Query the database to verify login credentials
        string query = "SELECT username FROM users WHERE username = ? AND password = ?";
        stream<record{}, error> resultStream = dbClient->query(query, username, password);

        // Check if user is found in the result set
        if (resultStream.hasNext()) {
            check caller->respond({ status: "success", message: "Login successful" });
        } else {
            check caller->respond({ status: "failure", message: "Invalid username or password" });
        }

        // Close the result stream
        check resultStream.close();
    }

    // Registration resource
    resource function post register(http:Caller caller, http:Request req) returns error? {
        // Get the JSON payload from the request
        json payload = check req.getJsonPayload();

        // Safely retrieve username, password, and email from JSON
        string username = check payload["username"].toString();
        string password = check payload["password"].toString();
        string email = check payload["email"].toString();

        // Handle null or invalid input
        if username == "" || password == "" || email == "" {
            check caller->respond({ status: "failure", message: "Invalid input" });
            return;
        }

        // Insert new user into the database
        string insertQuery = "INSERT INTO users (username, password) VALUES (?, ?)";
        sql:ExecutionResult result = check dbClient->execute(insertQuery, username, password);

        // Respond with success if insertion is successful
        check caller->respond({ status: "success", message: "Registration successful" });
    }
}

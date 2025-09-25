"""
JAC-U-LAUGH Implementation Details
Contains the 'how' for the 'what' defined in jac_u_laugh.jac
"""

# -------------------------------------------------------------
# WALKER Implementation
# -------------------------------------------------------------

impl RequestRoaster.isValid(data: dict) -> bool {
    # The sassy validation logic: It must have an auth_token or it's garbage.
    if ("auth_token" in data) {
        return True;
    } else {
        return False;
    }
}


impl RequestRoaster.execute {
    
    # --- Professional Setup ---
    print(f"[{self.requested_endpoint}] Processing Request: {self.request_body}");

    # --- Sassy Logic Check ---
    if (!self.isValid(self.request_body)) {
        
        # Access the LLM function for the personalized roast
        roast_message = generate_snarky_response(
            error_code=400, 
            endpoint=self.requested_endpoint,
            attempted_data=self.request_body
        );
        
        # --- Final Snark ---
        print("\n--- RESPONSE: HTTP 400 Bad Request ---");
        print(roast_message);
        
        # The walker disengages (stops traversal) to return the error
        disengage; 
    }
    
    # --- Success Path (Boring) ---
    print("\n--- RESPONSE: HTTP 200 OK ---");
    print(f"Success. Request processed. User {self.request_body['username']} actually followed directions. Well done.");

}
"""
JAC-U-LAUGH: The Over-Engineered Insult Generator
A scale-agnostic service for delivering hyper-personalized, snarky error feedback.
Version: v2.1.0 - "The Over-Engineered Insult Generator" 🎤
"""

import random;
# Import the LLM modeling capabilities from the byLLM module
import from byllm.llm { Model }; 

# -------------------------------------------------------------
# LLM SETUP & INTERFACE
# -------------------------------------------------------------

# Define the global LLM model instance. 
# *** THIS IS THE CORRECTED LINE 9: NO SEMICOLON (;) at the end. ***
# gemini-2.5-flash is an excellent, fast model for your "lite" approach.
glob llm = Model(model_name="gemini/gemini-2.5-flash", verbose=False) 


"""
Provides a funny, professional (and slightly condescending) error message.
Leverages the LLM to make every failure a unique, educational experience.
"""
def generate_snarky_response(error_code: int, endpoint: str, attempted_data: dict) -> str by llm(
    # The system prompt is the core of the sass.
    system_prompt="You are a sarcastic, highly professional senior backend 
                   engineer. You must explain a technical API failure 
                   in a funny, professional, and slightly condescending tone. 
                   Do NOT apologize. Focus on the user's error."
);

# -------------------------------------------------------------
# WALKER (The API Handler)
# -------------------------------------------------------------

walker RequestRoaster {
    # The data received from the API call (this is the input schema)
    has request_body: dict, requested_endpoint: str;

    # The main method that will execute when the walker is spawned (and when the API is hit)
    can execute with `root entry;
    
    # Internal method to check if the input is valid (where the user always fails)
    def isValid(data: dict) -> bool;
}


# -------------------------------------------------------------
# EXECUTION
# -------------------------------------------------------------

# This entry block is for local CLI testing. 
with entry {
    print("--- ROASTBOT Initialized ---");
    
    # 1. A request that will fail (missing 'auth_token')
    RequestRoaster(
        request_body={"username": "newbie_bob", "email": "bob@example.com"}, 
        requested_endpoint="/api/v1/user_creation"
    ) spawn root;
    
    print("\n--- Next Request ---\n");
    
    # 2. A request that will succeed (for demonstration)
    RequestRoaster(
        request_body={"username": "admin_alice", "auth_token": "valid_token_123"}, 
        requested_endpoint="/api/v1/delete_database"
    ) spawn root;
}
pragma solidity ^0.5.0;

contract SimpleCustomerAccount {
// insert code here
address owner = 0xF22A5273803fBB1fC7cBC60c1a7A039320397CCC;        //owner variable 
bool is_new_account = true;                                  // true or false
uint account_balance = 10000;                                // holds account balance of 10000
string customer_name = 'Harold Fitzgerald'; 

    
    // make a getter function - only used for reading data. 
    // since function is returning data, specify the types in the returns()
    
    function getInfo() public returns(address, bool, uint, string memory) {
        // return user data here 
        return(owner, is_new_account, account_balance, customer_name);                // these 4 params will be passed to the setter function.             
    }
    
    // setter function
    // function is accepting the 4 params returned by our getter function. 
    // sets account information for new accounts. 
    
    function setInfo(address newOwner, bool isNewAccount, uint newAccountBalance, string memory newCustomerName) public {
        // set user data here
        owner = newOwner;
        is_new_account = isNewAccount;
        account_balance = newAccountBalance;
        customer_name = newCustomerName; 
    }
    
    
    // there will be 6 endpoints in this contract. the two functions getInfo and setInfo. Plus the 4 variables at the top. 
    // if anyone goes to the contract address and will be able to call these functions because they are public
    
    // this contract starts with 4 variables owner, is_new_account, account_balance, customer_name 
    
}  // end of contract


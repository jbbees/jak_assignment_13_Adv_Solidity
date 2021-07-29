pragma solidity ^0.5.0;

// lvl 1: equal split
contract AssociateProfitSplitter {
    // @TODO: Create three payable addresses representing `employee_one`, `employee_two` and `employee_three`
    
    address payable employee_one;
    address payable employee_two;
    address payable employee_three;
    
    
    
    
    //constructor makes the contract re-useable.
    // constructor activates when we deploy contract 
    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    function balance() public view returns(uint) {             // view flag tells function not use gas. this is read-only. 
        return address(this).balance;                          // returns the balance of the address calling the function. 
    }

    function deposit() public payable {                        // not passing params in the deposit function for some reason 
        // @TODO: Split `msg.value` into three
        uint amount = msg.value / 3 ; // Your code here!

        // @TODO: Transfer the amount to each employee
        // Your code here!
        
        employee_one.transfer(amount);                         // deposit into employee 1 account
        employee_two.transfer(amount);                         // deposit into employee 2 account
        employee_three.transfer(amount);                       // deposit into employee 3 account

        // @TODO: take care of a potential remainder by sending back to HR (`msg.sender`)
        // Your code here!
        
        msg.sender.transfer(msg.value - amount *3 ); // sends remainder back to msg.sender. 
        
        
        
        
    }

    function() external payable {
        deposit();
        // @TODO: Enforce that the `deposit` function is called in the fallback function!
        // Your code here!
        
        // having deposit() in our fallback function throws gas limitation exceeded errors. 
        
        
        
    }
}

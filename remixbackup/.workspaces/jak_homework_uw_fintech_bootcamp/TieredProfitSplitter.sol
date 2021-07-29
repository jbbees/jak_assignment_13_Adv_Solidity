pragma solidity ^0.5.0;

// lvl 2: tiered split
contract TieredProfitSplitter {
    address payable employee_one; // ceo
    address payable employee_two; // cto
    address payable employee_three; // bob

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    // Should always return 0! Use this to test your `deposit` function's logic
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        uint points = msg.value / 100; // Calculates rudimentary percentage by dividing msg.value into 100 units
        uint total;
        uint amount;

        // @TODO: Calculate and transfer the distribution percentage
        
        // Step 1: Set amount to equal `points` * the number of percentage points for this employee
        
        amount = points * 60;     // points = 100, ceo amount will be 60% or 60/100 
        
       // Step 2: Add the `amount` to `total` to keep a running total
        
        total += amount;            // total = 60 distributed. 40 remaining. 
        
        // Step 3: Transfer the `amount` to the employee
        // @TODO: Repeat the previous steps for `employee_two` and `employee_three`
        
        // Your code here!
        
        employee_one.transfer(amount);        // CEO will get their 60. Amount becomes 0 afterwards.
        
        
        // Repeat for Employee 2
        
        amount = points * 25;                         // points = 100, cto amount will be 25% or 25/100 
        total += amount;                              // total = 60 + 25 = 85, 15 remaining 
        employee_two.transfer(amount);                // CTO gets their 25, amount goes back to zero. 

        // Repeat for Employee 3
        
        amount = points * 15;                         // points = 100. bob gets 15% or 15/100
        total += amount;                              // total = 60 + 25 + 15 = 100 
        employee_three.transfer(amount);              // bob gets his 15 

        // Give remainder in total back to CEO
        employee_one.transfer(msg.value - total); // ceo gets the remaining wei - 100 total.
       
    }

    function() external payable {
        deposit();                                // Make 
    }
}

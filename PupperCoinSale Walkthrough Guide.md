# PupperCoin and PupperCoinSale Walkthrough

In this github repo you will see two .sol files: a **PupperCoin.sol** and **Crowdsale.sol**. PupperCoin will generate our token asset. Crowdsale will generate a token sale of the asset made with PupperCoin.sol and collect the money from the buyers.

We will also need to make use of various OpenZeppelin libraries that we will need.

## PupperCoin.sol

* PupperCoin contract makes the token asset itself. **This token is what we are selling in the crowdsale to buyers for money.**

* To make our token we need to import ERC20 OpenZeppelin libraries from github that will make our token in the ERC20 Standard. Our contract will inherit the code from these imported programs.

> <https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol>
> <https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol>
> <https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol>

* The main token constructor will need to pass three core parameters needed to mint the token:

1. *token name* which is passed as a **uint** type.

2. *token symbol* which is a **string** type, but will also will add the **memory** decorator for gas-optimizing purposes.

3. *initial_supply*. This will be the beginning supply of the tokens made for the crowdsale. But it will be zero.

**NOTE:**

* The ERCO20Detailed constructor will be empty. This is because the contract owner deploying this minting contract will be another contract, **PupperCoinSale**. When the sale goal is reached, and the allotted time span for the sale has concluded, the contract is finalized and the minter will be called to mint the tokens.  

* Typically we limit asset creation to the owner, or **msg.sender** who deployed the contract. We will be having another contract be the deployer for this contract. So we do not need to have code in the constructor. It will cause deployment problems.

* In this crowdsale, we are minting our tokens **only when the goal of the crowdsale is reached**. When the sale goal is reached, the crowdsale will finalize and mint the tokens. So the intitial supply of the token starts at zero. As a buyer pays us for a token, calling the crowdsale contract, the contract will store the wallet address of the buyer and the funds they giving us for tokens. When the sale goal is reached, then our PupperCoin contract is called and mints all the tokens per buyer.  

## Crowdsale.sol

* This contract will create a crowdsale and deploy that crowdsale onto the blockchain, so buyers on the network can buy our PupperCoin tokens. These token will only be created and distributed to donors once the crowdsale is finalized. It only finalizes when the sale goal of 300 is reached, and the time span of 24 weeks has passed.

* The crowdsale in this contract will go on for **24 weeks.** Even if the sale reaches its 300 goal, buyers will not get their tokens until 24 weeks after they made the purchase.

* When the goal is reached. Buyers will not be able to buy anymore tokens.

* Our buyers pay money in ehter, their wallet addresses will be stored in the contract. That address will get the token.  

* This contract will have 2 contracts: **PupperCoinSale** to make the token sale and call the PupperCoin minter to make the token. **PupperCoinSaleDeployer** will receive the money from the buyer, and sets the exchange rate per token.

## PupperCoinSale

![PupperCoinSale](PupperCoinSale.png)

* This contract will update the goal of the sale, finalize the tokens to buyers, mint the tokens, and refund buyers if the crowdsale is not successful.

* This contract will inherit code from the OpenZeppelin libraries:

> <https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol>
> <https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol>
> <https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol>
> <https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol>
> <https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol>

* Main constructor will have six core parameters:

1. *rate* as in 1 ether paid by buyer = 1 token minted
2. *wallet* that we pay the tokens to the buyers. Needs a **payable** decorator.
3. *token* the PupperCoin token itself.
4. *goal* which updates every token purchase
5. *open* date the token was bought.
6. *close* allotted date after the open to mint and distribute the tokens.

* We will add secondary constructors to deal with the different functions of the sale.

* *CappedCrowdsale* constructor requires the **goal** param.  Will cap buying PupperCoin token after the goal is reached. When the goal is reached buyers will not be able to buy more tokens.

* *TimedCrowdsale* constructor keeps track of the timestamp when a token is purchased. Tokens are distributed 24 weeks after the timestamp of the purchase, should the contract finalize. Requires the **open** and **close** params. Open being the time the token is bought. Close is 24 weeks after the open.

* *RefundableCrowdSale* constructor will refund the buyers their ether if the sale goal isn't reached. It requires the **goal** parameter.  

## PupperCoinSaleDeployer

![PupperCoinDeployer](PupperCoinDeployer.png)

* This contract will inherit no code at all.

* We'll define 2 main contract **address** variables to store both the **wallet addresses of buyers** buying tokens, and **contract address of the token sale** to mint the token for that buyer.

* *token_sale_address* will store the contract address of PupperCoinSale.

* *token_address* will store the wallet address of the buyer.

![ContractVariables](PupperCoinDeployer1.png)

* The main constructor will have four parameters passed:

1. *token name* as **string** with **memory** decorator. We use memory on strings to optimize for gas.
2. *token symbol* as a string with memory decorator.
3. address **payable** wallet. This the wallet that recieves the funds from the buyers. It needs to be made payable for the obvious reason.
4. *goal* **uint** to keep track of the target we're trying to hit with the crowdsale. As tokens are purchased the goal will be updated until reached. Then buying is capped out. 

![ConstructorParams](PupperCoinDeployer3.png)

* The deployer {} part of the constructor is going to store the addresses of all the buyers as the contract is called. It also sets the rate of how many tokens we get per 1 ether spent. 

* First part will create PupperCoin token. It creates a new token, but sets the supply to zero. This token will only exist when the cotract finalizes.  
* Stores the buyers wallet address in token_address.

![BuyerInfo](PupperCoinDeployer4.png)

* Second part is going to keep track that the token sale exists. Create a new Crowdsale, set the rate of 1 ether = 1 token, update the goal of the sale by the ether we got from the buyer, and timestamp the sale, and then set the distribution of the token to 24 weeks later after sale. So If I buy 100 ether worth of tokens on 7-29-2021 at 12:00AM, I will expect to receive 100 tokens, and I won't get those token until 24 weeks have passed from that exact time. And stores the contract sale address, 

* We also store the contract address of the token sale. 
![TokenSale](PupperCoinDeployer5.png)

* Finally we need to re-assign token minting from the Deployer to the PupperCoinSale contract. We **addMinter** to add the minting role, and we **renounceMinter** in the Deployer. 
![MinterRole](PupperCoinDeployer6.png)

## Deploy the Contract

* To set the goal of the Crowdsale, enter a number amount in **wei**. Our goal is 300 ether. That's 300000000000000000000 wei. A converter is available to copy paste the wei needed.
[EthereumWeiConverter](https://eth-converter.com)

## Let's Buy Some PupperCoins

* Go into **Deploy & Run Transactions** section. 
* Make sure we're on our test Ganache network.
* Make sure the buying wallet address is imported/connected to the network, and has ether in it.
* Enter a value in **ether** that is above zero.
* Under **Contract** select the **PupperCoin.sol**.  
![SetupBuyer](PupperCoins8.png)

* In MetaMask, import the PupperCoin token into the **assets** tab of the wallet address. Click **Add Token**.
![AddTokens](PupperCoins2.png)

* Paste the **token address** in the Contract Address field. It will auto-fill the remaining. Click confirm. You'll see the **PUPPR** token in wallet assets.
![ConfirmToken](PupperCoins3.png)

* Under **Deployed Contracts** go to **PupperCoinSale**. Call the **buyTokens** function. Put the target wallet address that will be buying the tokens. Hit **Transact**.  
![buyTokens](PupperCoins1.png)

* MetaMask will confirm the purchase.
![ConfirmBuy](PUP1.png)

* In MetaMask, we'll see our 100 ether is gone. And we see bough 100 ETH worth of those tokens. But we will not see 100 PUPPR coins until contract is finalized.
![BoughtTokens](PupperCoins4.png)

* If we're impatient waiting for our tokens we can call functions like **goalReached** which if met will be *True*, and to see the sale goal call the **goal** function.
![goalReached](PupperCoins5.png)

* If we want to see if the sale is finalized call **finalized** if *False* that means we'll have to wait until it finsihes to get the tokens we bought.
![Finalized](PupperCoins6.png)

* If you receive this error, it means the cap exceeded. The sale goal was reached. New tokens cannot be bought.
![CapExceeded](PupperCoins7.png)

* If you want a refund call the **claimRefund** function. Paste in your wallet address and hit transact.
![Refund](PupperCoins9.png)

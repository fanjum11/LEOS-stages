# LEOS in stages

This repo takes the LEOS project (https://github.com/fanjum11/leos) and breaks it down into 8 modules.

Each successive module builds on the previous one.

The goal is to demonstrate to the reader how a complete Clarity smart contract is created.

A side effect of this is also to help analyze the code for bugs etc.

# Pre-reqs
We expect the reader to have downloaded Clarinet. 

In addition we expect the reader to also be aware of the Clarity language. If not please refer to the book given at https://book.clarity-lang.org/ 
In this explanation we will look at understanding the use of the concepts explained in this book.

# Objective of LEOS

To create a learn to earn platform.
Details of LEOS are given at https://github.com/fanjum11/leos 

We can see from there that we have three actors in the LEOS ecosystem 

1. Contract (Platform) creator - they get STX in return for edu tokens for the service provided.
2. Company or Product owners - they pay STX to get edu tokens that are then awarded to the winners of the various quizzes.
3. Inviduals - they answer quizzes and get rewarded in edu tokens if they win the competition.

The code here does not consider the front end. It focuses only on the smart contract.

In order to understand this code, we divide it into modules as given below.

# Division into modules 

The LEOS contract consists of three files as given in the contracts directory above. these files are given at the link https://github.com/fanjum11/leos/tree/main/contracts 
- create_eval_earn.clar -- this is the gist of the Clarity smart contract
- edu-token-trait.clar -- this is the template of a special contract. It provides 4 functions that have to be implemented by any special contract that follows this template. The template itself just provides the signatures of these 4 functions.
- edu-token.clar - this is a "special contract" referred to above which implements the 4 functions given in the edu-token-trait.clar.

The functionality of LEOS is divided into the following 8 modules 

- Module 1: consists of the edu-token-trait template along with the implementation of the template in the edu-token contract. In addition, this also provides for a "course creator" to buy EDU tokens by paying STX. The main contract is called M1 here.
- Module 2: consists of a function test-init. this is used by the company to initialize a test (quiz) and to transfer edu tokens to the smart contract. These edu tokens are the reward for those wallets that successfully answer the test. The main contract is called M2 here.
- Module 3: This builds on module 2. And it adds two functions to get the details of the tests available to a user.
- Module 4: This focuses on two functions. One of the function allows for answers being provided by the individual during the open phase of the quiz. Another function allows for the quiz-creator to provide answers once the test is locked.
- Module 5: 

## Module 1

Some more details about the functions in module 1


### Explanation 

Explain the code in more detail by 
- focusing on the nuances of Clarity and the keywords and functions
- and also the tests 

### Open Questions

Then ask questions that the user can verify by making mods to the clarity code.

## Module 2



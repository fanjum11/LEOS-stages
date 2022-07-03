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

1. Contract (Platform) creator
2. Company or Product owners
3. Inviduals

The code here does not consider the front end. It focuses only on the smart contract.

In order to understand this code, we divide it into modules as given below.

# Division into modules 

The LEOS contract consists of three files as given in the contracts directory above. these files are given at the link https://github.com/fanjum11/leos/tree/main/contracts 
- create_eval_earn.clar -- this is the gist of the Clarity smart contract
- edu-token-trait.clar -- this is the template of a special contract. It provides 4 functions that have to be implemented by any special contract that follows this template. The template itself just provides the signatures of these 4 functions.
- edu-token.clar - this is a "special contract" referred to above which implements the 4 functions given in the edu-token-trait.clar.

The functionality of LEOS is divided into the following 8 modules 



## Module 1


### Explanation 


### Open Questions


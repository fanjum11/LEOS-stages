import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.31.1/index.ts';

import { assert, assertEquals }
  from 'https://deno.land/std@0.125.0/testing/asserts.ts';



//import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.14.0/index.ts';
//import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';
  
  Clarinet.test({
    name: "Ensure that transfer can only be called by token owner",
    async fn(chain: Chain, accounts: Map<string, Account>) {
      var owner = accounts.get("wallet_1")!;
      var notOwner = accounts.get("wallet_2")!;
  
      let block = chain.mineBlock([
        Tx.contractCall(
          "edu-token",
          "mint",
          [types.uint(10), types.principal(owner.address)],
          owner.address
        ),
        Tx.contractCall(
          "edu-token",
          "transfer?",
          [
            types.uint(1),
            types.principal(owner.address),
            types.principal(notOwner.address),
          ],
          notOwner.address
        ),
        Tx.contractCall("edu-token", "burn", [types.uint(1)], owner.address),
      ]);
  
      block.receipts[1].result.expectErr().expectUint(100);
    },
  });
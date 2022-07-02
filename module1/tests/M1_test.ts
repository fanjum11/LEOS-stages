import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.31.1/index.ts';

import { assert, assertEquals }from 'https://deno.land/std@0.125.0/testing/asserts.ts';


Clarinet.test({
    name: "Ensure that any creator can buy edu tokens",
    async fn(chain: Chain, accounts: Map<string, Account>) {
      var deployer = accounts.get("deployer")!;
      var tokenTrait = `${deployer.address}.edu-token`;
      var edu_token = 1000; 
  
      let block = chain.mineBlock([
        Tx.contractCall(
          "M1",
          "purchase_edu_token",
          [types.principal(tokenTrait), types.uint(edu_token)],
          deployer.address
        ),
      ]);
      block.receipts[0].result.expectOk().expectBool(true);
      assertEquals("(ok true)", block.receipts[0].result);
    },
  });
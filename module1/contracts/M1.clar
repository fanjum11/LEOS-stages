
;; M1
;; <add a description here>

;; constants
;;

;; data maps and vars
;;

;; private functions
;;

;; public functions
;;
;; identify the functions needed in each module
;; explain the maps, vars, traits used in this function 
;; and build up the complete solution 

;; first module
;; get the trait ; explain what is needed for the trait 

;; second module
;; purchase_edu_token

;;third module
;; get_max_test_id
;; test_init 
;; transfer_token_to_contract

;; fourth module
;; answer_proof_by_test_taker
;; answers_by_creator

;;fifth module
;; get_correct_answers
;; detailed_answers_by_test_takers  

;; sixth module
;; get-test-winners
;; verify_answer 
;; did_I_win 

;; seventh module
;; get_final_list_of_winners
;; get_my_award 


;; eight module
;; get_test_details
;; pay_remainder_to_contract_owner

(use-trait edu-token-trait .edu-token-trait.edu-token-trait)

(define-constant ERR_NOT_ENOUGH_STX_TO_MINT_TOKEN (err u1012))

(define-constant stx-per-edu-token u1000) ;;

(define-public (purchase_edu_token (token-trait <edu-token-trait>) (edu_token_amount uint))
    (let
        (
            (required_stx (* stx-per-edu-token edu_token_amount))
        )
        (asserts! (>= (stx-get-balance tx-sender) required_stx) ERR_NOT_ENOUGH_STX_TO_MINT_TOKEN)
        (try! (stx-transfer? required_stx tx-sender (as-contract tx-sender)))
        (try! (contract-call? token-trait mint edu_token_amount tx-sender))
        (ok true)
    )
)

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

;;second module
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

(define-constant ERR_NOT_ENOUGH_TOKEN (err u1006))
(define-constant ERR_TOKEN_CALL_FAIL (err u1007))
(define-constant ERR_NOT_ENOUGH_STX_TO_MINT_TOKEN (err u1012))
(define-constant ERR_TEST_DETAILS_UNAVAILABLE (err u1015))

(define-constant stx-per-edu-token u1000) ;;
(define-data-var test-id-count uint u0)
(define-constant test-reward-claim-duration u1000)

(define-map test_details {id: uint} 
        {
            creator: principal,
            number_ques: uint,
            total_prize_money: uint,
            test_grade_starting_at_block: uint, 
            test_grade_closed_at_block: uint, 
            test_answers_hash: (buff 256),
            test_topic: (string-ascii 64),
            test_at_link: (string-ascii 128),
            min_correct_answers_reqd: uint
        }
)

(define-map test_payment_status {test_id: uint}
    {
        prize_amount_paid: uint
    }
)

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

(define-public (test_init
        (token-trait <edu-token-trait>)
        (num_ques uint)
        (num_correct_answers uint)
        (prize_amount uint)
        (blocks_test_open_for uint)
        (answer_hash_key (buff 256)) ;; hash (answers + secret)
        (topic_of_test (string-ascii 64) )
        (test_available_at_link (string-ascii 128))
        ) 
    (let
        (
            (test_id (+ (var-get test-id-count) u1))
            (test_end_block (+ block-height blocks_test_open_for))
            (reward_claim_after_block (+ test_end_block test-reward-claim-duration))

        )
        (try! (transfer_token_to_contract token-trait prize_amount))
        (var-set test-id-count test_id) ;; no test_id of zero
        (map-set test_details {id: test_id} 
                    {
                        creator: tx-sender, 
                        number_ques: num_ques,
                        total_prize_money: prize_amount, 
                        test_grade_starting_at_block: test_end_block,
                        test_grade_closed_at_block: reward_claim_after_block, 
                        test_answers_hash: answer_hash_key,
                        test_topic: topic_of_test,
                        test_at_link: test_available_at_link,
                        min_correct_answers_reqd: num_correct_answers
                    }
        )
        (map-set test_payment_status {test_id: test_id}
            {
                prize_amount_paid: u0
            } 
        
        )
        (ok test_id)
    )
)

(define-private (transfer_token_to_contract (token-trait <edu-token-trait>) (token_amount uint))
    (let
        (
            (user_token (unwrap! (contract-call? token-trait get-balance tx-sender) ERR_TOKEN_CALL_FAIL))
        )
        (asserts! (>= user_token token_amount) ERR_NOT_ENOUGH_TOKEN)
        (try! (contract-call? token-trait transfer? token_amount tx-sender (as-contract tx-sender)))
        (ok true)
    )
)

(define-read-only (get_max_test_id)
    (ok (var-get test-id-count))
)

(define-read-only (get_test_details (test_id uint) )
(let
    (
        (test_details_req (unwrap! (map-get? test_details {id: test_id}) ERR_TEST_DETAILS_UNAVAILABLE )) 
    )
    (ok test_details_req)
)
)


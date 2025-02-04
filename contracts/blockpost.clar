
;; title: blockpost
;; version:
;; summary: contract that writes a post on chain for a small fee 
;; description:

;; traits
;;

;; token definitions
;;

;; constants
(define-constant contract-owner tx-sender) ;;tx-sender = contract deployer

(define-constant price u1000000) ;; = 1STX
;;

;; data vars
(define-data-var total-post uint u0)
;;

;; data maps
(define-map posts principal (string-utf8 500))
;;

;; public functions
(define-public (write-post (message (string-utf8 500))) 
    (begin 
    (try! (stx-transfer? price tx-sender contract-owner))
    (map-set posts tx-sender message)
    (var-set total-post (+ (var-get total-post) u1)) ;;logic to increment the total post
    (ok "Success")
    )
)
;;

;; read only functions
(define-read-only (get-total-posts) 
    (var-get total-post)
)

(define-read-only (get-post (user principal)) 
    (map-get? posts user))
;;

;; private functions
;;


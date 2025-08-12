

;; Carbon Offset Token - Basic Version
;; This contract issues tokens that represent a unit of carbon offset (e.g., 1 token = 1 ton CO2 offset)

(define-fungible-token carbon-offset-token)

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-invalid-amount (err u101))

;; Data variables
(define-data-var total-supply uint u0)

;; Mint Carbon Offset Tokens (Only Owner)
(define-public (mint-offset (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (> amount u0) err-invalid-amount)
    (try! (ft-mint? carbon-offset-token amount recipient))
    (var-set total-supply (+ (var-get total-supply) amount))
    (ok true)))

;; Get Total Carbon Offsets Issued
(define-read-only (get-total-offsets)
  (ok (var-get total-supply)))
#lang racket

(require test-engine/racket-tests)
(check-expect (filter list? '(1 (2 3) 4 (5) 6))
(foldr (lambda (v l) (if (list? v) (cons v l) l)) '() '(1 (2 3) 4 (5) 6))
              )

(check-expect (map number->string '(1 2 3 4 5)) 
(foldr (lambda (v l)  (cons (number->string v) l) ) '() '(1 2 3 4 5))
              )


(define (filter pred? lst) 
  (foldr (lambda (x acc) (if (pred? x) (cons x acc) acc)  )
         '()
         lst))

; "meta variable"
; formal peramatres are not proper sub expresions 
; and do not automaticaly become free variables
; in lanbda calculus, all "values" are lambdas
; alfa-conversion states (lambda (x) e_b) => (lambda (y)  e_b[x \mapsto y])

; capture avoiding substitution is relaited to the free variable function
; eighta reduction/ eighta expansion

(test)

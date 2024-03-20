#lang racket

(require test-engine/racket-tests)
(define (filter pred? lst) 
  (foldr (lambda (x acc) (if (pred? x) (cons x acc) acc)  )
         '()
         lst))

(check-expect (filter list? '(1 (2 3) 4 (5) 6)) '((2 3) (5)))
(test)

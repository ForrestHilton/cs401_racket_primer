#lang racket

(require test-engine/racket-tests)

(define (interleave l1 l2) (if (null? l1) '() 
   `(,(car l1) ,(car l2) . ,(interleave (cdr l1) (cdr l2))) ))

(check-expect (interleave '(0 2 4) '(1 3 5))
  '(0 1 2 3 4 5))

(test)

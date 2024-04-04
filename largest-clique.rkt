#lang racket

(require test-engine/racket-tests)

(define pairs '((2 0)
             (1 4)
             (4 0)
             (1 3)
             (2 1)
             (0 1)
             (3 4)
             (0 4)
             (4 1)
             (4 2)
             (1 0)))

(define (to->graph pairs) (if (null? pairs) (set)
    (match pairs [(cons (cons (? number? a) (? number? b)) tail)
(set (to->graph tail) (cons (min a b) (max a b)))] 
                  [_ "not a list of numbers"])
  ))

(define graph (to->graph pairs))
(print graph)

;; (define (connected graph a b) ())



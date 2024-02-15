#lang racket
(require test-engine/racket-tests)


(define a (cons 1 (cons (cons 2 '()) '())))
(check-expect a '(1 . ((2 . ()) . ())))
;; we need the dot so that that the quote does not implicitly make it a proper list. t
;; the dot means that the list is proper up t thier thier
(check-expect a '(1 (2)))


(define b (cons (cons (cons 1 2) '()) (cons 3 (cons '() '())) ) )
(check-expect b (cons (list (cons 1 2)) (cons 3 (list '() ))) )
;; (check-expect b ((list '(1 . 2)) . '(3 . (list '() ))) )
(check-expect b (list (list (cons 1 2)) 3 (list)) )
(check-expect b '(((1 . 2)) 3 ()) )
;; (cons 1 2) is not a proper list because it does not have a null in the cdr 

;; Both of these are structurally recursive because they follow the recursive structure of the data.
;; quicksort and fib are generatively recursive because the values determine the recursion not.
;; The structure lists have a natural recursive structure.
(define (mylist? lst) (if (null? lst) #t (if (cons? lst) [mylist? (cdr lst)] #f) ))
(define (mylistb? lst) (cond [(null? lst) #t] 
                             [ (cons? lst) (mylist? (cdr lst))] 
                             [else #f]) )

;; tail recursion means that there is no work after the recursive call
;; i.e. the solution to the sub problem needs no interpretation/expansion
;; to be a solution of the general problem
(define (mylistc? lst) (or (null? lst) (and (cons? lst) (mylistc? (cdr lst)))))

(check-expect (mylist? (list 1 2 3)) #t)
(check-expect (mylistb? (list 1 2 3)) #t)
(check-expect (mylistc? (list 1 2 3)) #t)
(check-expect (mylist? (cons 1 2)) #f)
(check-expect (mylistb? (cons 1 2)) #f)
(check-expect (mylistc? (cons 1 2)) #f)
;; this enabled by things like let because the body is in the tail position of the let because it returns the value of body directly
;; a tail recursive function does not grow the stack. Tail recursion is equivalent to iteration

;; natural/direct recursion like this means we still have work to do after our recursive call
(define (mylen lst) (cond [(null? lst) 0] 
                        [(null? lst) (+ 1 (len (cdr lst)))]
                        [else (error "not a list")]))

(check-expect (mylen (list 0 1 2 3)) 4)

; accumulator-passing style
; gives us tail call optimization (scheme grantees it, but cpp will make a best effort attempt)
(define (tail-len lst [count 0])
  (match lst [(cons _ tail) (tail-len tail (+ count 1))]
    ['() count]))

(check-expect (tail-len (list 0 1 2 3)) 4)
;; this is a higher order thing in Russle's type theory because the set that this represents is 
;; a function (relation) that is itself a function (relation)
;; (define (listof pred) (define (f lst) (match lst [(cons x tail) (and (pred x) (f tail))]
;;                                         ['() #t]
;;                                         [_ #f])))

;; structural recursion is following the structure of the data structure
(define (dropfront lst n) (if (= n 0) lst (if (cons? lst) (dropfront (cdr lst) n-1) '())) )
(test)

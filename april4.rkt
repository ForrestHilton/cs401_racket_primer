(let* ([n 1]) (add1 n)) ->
(let ([n 1]) (add1 n)) ->
((lambda (n) (add1 n)) 
 1) ->
((lambda (n) (
              (lambda (f) (lambda (x) (f ((n f) x))))
              n)) 
 (lambda (f) (lambda (x) (f x))))

;; write a recursive function using let* not letrec (hint: use U-comb)

(let* ([U (lambda (u) (u u))]
       [mkfib (lambda (mkfib) (lambda (n) (if (< n 2) 1 (let ([fib (U mkfib)]) 
                                (+ (fib (- n 1)) (fib (- n 2)))
                                ))) )]
       [fib (lambda (n) ((U mkfib) n))])
  (fib 5)
  )

;; another example to convert:
(letrec ([myappend (lambda (lst0 lst1) (if (null? lst0) lst1 (cons (car lst0) (myappend (cdr lst0) lst1))))]) (myappend '(1 2 3) '(4 5)))


;; derive the Y-comb:
x = (f x) ; is the meaning of the Y being a fixed point
f = (Y f)
; therefore
(Y f) = (f (Y f))
; therefore
Y = (lambda (f) (f (Y f)))
; ->
mkY = (lambda (mkY) (lambda (f) (f ((U mkY) f))))
Y = (U mkY)
; or simply:
Y = (U (lambda (mkY) (lambda (f) (f ((U mkY) f)))))
; f = ((U mkY) f) and Y = (U mkY) causes non-termination in CBV, but in CBN/CDNeed this is fine
; for CBV:
Y = (U (lambda (mkY) (lambda (f) (f (lambda (x) (((U mkY) f) x))))))


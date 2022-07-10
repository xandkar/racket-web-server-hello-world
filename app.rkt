#lang racket

(provide (contract-out
           [dispatch handler?]))

(require (prefix-in  srv:  web-server/servlet)
         (prefix-in  http: web-server/http)
         (prefix-in  dis:  web-server/dispatch))

(define handler?
  (-> srv:request? srv:response?))

(define-values (dispatch _handler->url)
  (dis:dispatch-rules
    [("")      handle-hello]
    [("hello") handle-hello]))

(define/contract (handle-hello req)
  handler?
  (http:response/output
    (λ (out-port)
       (displayln "Hello, world!" out-port))))

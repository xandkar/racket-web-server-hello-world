#lang racket

(provide (contract-out
           [handle-error-not-found  handler?]
           [handle-error-crash      (-> any/c exn? srv:response?)]))

(require (prefix-in  srv:  web-server/servlet)
         (prefix-in  http: web-server/http))

(define handler?
  (-> srv:request? srv:response?))

(define/contract (handle-error-not-found req)
  handler?
  (srv:response/xexpr
    '(html (head (title "error 404 : not found"))
      (body "not found"))
    #:code 404))

(define/contract (handle-error-crash url exn)
  (-> any/c exn? srv:response?)
  (srv:response/xexpr
    '(html (head (title "error 500 : internal server error"))
      (body "internal server error"))
    #:code 500))
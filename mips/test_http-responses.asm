###
# File: test_http-responses.asm
#
# Code to exercise http response routines.
###

.include "util-macros.asm"

.data
test_pass:      .asciiz "TEST PASSED.\n"
test_fail:      .asciiz "==> TEST FAILED!\n"
test_start:     .asciiz "STARTING TESTS.\n"
test_end:       .asciiz "FINISHED TESTS.\n"

_method_name_not_allowed_resp: .asciiz "HTTP/1.1 405 METHOD NAME NOT ALLOWED\r\n\r\n"

.text
.globl main

main:
        print(test_start)
        print(test_end)
        exit(0)

pass:
        print(test_pass)
        jr $ra

fail:
        print(test_fail)
        jr $ra

############################### _return_method_name_not_allowed ##############################

test_return_method_name_not_allowed:
  push($ra)
  jal _return_method_name_not_allowed
  move $a0, $v0
  la $a1, _method_name_not_allowed_resp
  jal strncmp
  pop($ra)
  bne $v0, $zero, fail
  j pass

.include "http-responses.asm"
.include "string.asm"

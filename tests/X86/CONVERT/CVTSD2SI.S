/* Copyright 2016 Peter Goodman (peter@trailofbits.com), all rights reserved. */

#define CVTSD2SI_INPUTS \
    TEST_INPUTS( \
        0x7ff0000000000000,  /* +inf */ \
        0xfff0000000000000,  /* -inf */ \
        0x10000000000000,  /* std::numeric_limits<double>::min() */ \
        0x7fefffffffffffff,  /* std::numeric_limits<double>::max() */ \
        0x0,  /* 0 */ \
        0x3fe0000000000000,  /* 0.5 */ \
        0xbfe0000000000000,  /* -0.5 */ \
        0x3ff0000000000000,  /* 1.0 */ \
        0xbff0000000000000,  /* -1.0 */ \
        0x4058ff5c28f5c28f,  /* 99.99 */ \
        0xc058ff5c28f5c28f)  /* -99.99 */

TEST_BEGIN_64(CVTSD2SIr32m64, 1)
CVTSD2SI_INPUTS

    mov QWORD PTR [rsp - 8], ARG1_64
    cvtsd2si eax, QWORD PTR [rsp - 8]
TEST_END_64

TEST_BEGIN_64(CVTSD2SIr32v128, 1)
CVTSD2SI_INPUTS

    movq xmm0, ARG1_64
    cvtsd2si eax, xmm0
TEST_END_64

TEST_BEGIN_64(CVTSD2SIr64m64, 1)
CVTSD2SI_INPUTS

    mov QWORD PTR [rsp - 8], ARG1_64
    cvtsd2si rax, QWORD PTR [rsp - 8]
TEST_END_64

TEST_BEGIN_64(CVTSD2SIr64v128, 1)
CVTSD2SI_INPUTS

    movq xmm0, ARG1_64
    cvtsd2si rax, xmm0
TEST_END_64

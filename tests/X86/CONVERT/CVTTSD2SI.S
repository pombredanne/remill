/* Copyright 2016 Peter Goodman (peter@trailofbits.com), all rights reserved. */

TEST_BEGIN_64(CVTTSD2SIr32m64, 1)
TEST_INPUTS(
    0x10000000000000,  // std::numeric_limits<double>::min()
    0x7fefffffffffffff,  // std::numeric_limits<double>::max()
    0x0,  // 0
    0x3fe0000000000000,  // 0.5
    0xbfe0000000000000,  // -0.5
    0x3ff0000000000000,  // 1.0
    0xbff0000000000000,  // -1.0
    0x4058ff5c28f5c28f,  // 99.99
    0xc058ff5c28f5c28f)  // -99.99

    mov QWORD PTR [rsp - 8], ARG1_64
    cvttsd2si eax, QWORD PTR [rsp - 8]
TEST_END_64

TEST_BEGIN_64(CVTTSD2SIr32v128, 1)
TEST_INPUTS(
    0x10000000000000,  // std::numeric_limits<double>::min()
    0x7fefffffffffffff,  // std::numeric_limits<double>::max()
    0x0,  // 0
    0x3fe0000000000000,  // 0.5
    0xbfe0000000000000,  // -0.5
    0x3ff0000000000000,  // 1.0
    0xbff0000000000000,  // -1.0
    0x4058ff5c28f5c28f,  // 99.99
    0xc058ff5c28f5c28f)  // -99.99

    movq xmm0, ARG1_64
    cvttsd2si eax, xmm0
TEST_END_64

TEST_BEGIN_64(CVTTSD2SIr64m64, 1)
TEST_INPUTS(
    0x10000000000000,  // std::numeric_limits<double>::min()
    0x7fefffffffffffff,  // std::numeric_limits<double>::max()
    0x0,  // 0
    0x3fe0000000000000,  // 0.5
    0xbfe0000000000000,  // -0.5
    0x3ff0000000000000,  // 1.0
    0xbff0000000000000,  // -1.0
    0x4058ff5c28f5c28f,  // 99.99
    0xc058ff5c28f5c28f)  // -99.99

    mov QWORD PTR [rsp - 8], ARG1_64
    cvttsd2si rax, QWORD PTR [rsp - 8]
TEST_END_64

TEST_BEGIN_64(CVTTSD2SIr64v128, 1)
TEST_INPUTS(
    0x10000000000000,  // std::numeric_limits<double>::min()
    0x7fefffffffffffff,  // std::numeric_limits<double>::max()
    0x0,  // 0
    0x3fe0000000000000,  // 0.5
    0xbfe0000000000000,  // -0.5
    0x3ff0000000000000,  // 1.0
    0xbff0000000000000,  // -1.0
    0x4058ff5c28f5c28f,  // 99.99
    0xc058ff5c28f5c28f)  // -99.99

    movq xmm0, ARG1_64
    cvttsd2si rax, xmm0
TEST_END_64

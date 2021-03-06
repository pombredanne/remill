/* Copyright 2016 Peter Goodman (peter@trailofbits.com), all rights reserved. */

TEST_BEGIN_64(CVTPS2PDv128m128, 1)
TEST_INPUTS(
    0x7f7fffff00800000,  // std::numeric_limits<double>::min(), max
    0x0080000000000000,  // std::numeric_limits<double>::max(), 0
    0x000000003f000000,  // 0, 0.5
    0x3f000000bf000000,  // 0.5, -0.5
    0xbf0000003f800000,  // -0.5, 1.0
    0x3f800000bf800000,  // 1.0, -1.0
    0xbff0000047c34fc0)  // -1.0, 99999.5

    push ARG1_64
    cvtps2pd xmm0, QWORD PTR [rsp]
TEST_END_64

TEST_BEGIN_64(CVTPS2PDv128v128, 1)
TEST_INPUTS(
    0x7f7fffff00800000,  // std::numeric_limits<double>::min(), max
    0x0080000000000000,  // std::numeric_limits<double>::max(), 0
    0x000000003f000000,  // 0, 0.5
    0x3f000000bf000000,  // 0.5, -0.5
    0xbf0000003f800000,  // -0.5, 1.0
    0x3f800000bf800000,  // 1.0, -1.0
    0xbff0000047c34fc0)  // -1.0, 99999.5

    movq xmm4, ARG1_64
    cvtps2pd xmm0, xmm4
    cvtps2pd xmm2, xmm3
TEST_END_64

#if HAS_FEATURE_AVX

TEST_BEGIN_64(VCVTPS2PDv128m128, 1)
TEST_INPUTS(
    0x7f7fffff00800000,  // std::numeric_limits<double>::min(), max
    0x0080000000000000,  // std::numeric_limits<double>::max(), 0
    0x000000003f000000,  // 0, 0.5
    0x3f000000bf000000,  // 0.5, -0.5
    0xbf0000003f800000,  // -0.5, 1.0
    0x3f800000bf800000,  // 1.0, -1.0
    0xbff0000047c34fc0)  // -1.0, 99999.5

    push ARG1_64
    vcvtps2pd xmm0, QWORD PTR [rsp]
TEST_END_64

TEST_BEGIN_64(VCVTPS2PDv128v128, 1)
TEST_INPUTS(
    0x7f7fffff00800000,  // std::numeric_limits<double>::min(), max
    0x0080000000000000,  // std::numeric_limits<double>::max(), 0
    0x000000003f000000,  // 0, 0.5
    0x3f000000bf000000,  // 0.5, -0.5
    0xbf0000003f800000,  // -0.5, 1.0
    0x3f800000bf800000,  // 1.0, -1.0
    0xbff0000047c34fc0)  // -1.0, 99999.5

    movq xmm4, ARG1_64
    vcvtps2pd xmm0, xmm4
TEST_END_64


TEST_BEGIN_64(VCVTPS2PDv256m128, 2)
TEST_INPUTS(
    0x7f7fffff00800000,  // std::numeric_limits<double>::min(), max
    0x0080000000000000,  // std::numeric_limits<double>::max(), 0
    0x000000003f000000,  // 0, 0.5
    0x3f000000bf000000,  // 0.5, -0.5
    0xbf0000003f800000,  // -0.5, 1.0
    0x3f800000bf800000,  // 1.0, -1.0
    0xbff0000047c34fc0)  // -1.0, 99999.5

    push ARG1_64
    push ARG2_64
    vcvtps2pd ymm0, XMMWORD PTR [rsp]
TEST_END_64

TEST_BEGIN_64(VCVTPS2PDv256v128, 2)
TEST_INPUTS(
    0x7f7fffff00800000,  // std::numeric_limits<double>::min(), max
    0x0080000000000000,  // std::numeric_limits<double>::max(), 0
    0x000000003f000000,  // 0, 0.5
    0x3f000000bf000000,  // 0.5, -0.5
    0xbf0000003f800000,  // -0.5, 1.0
    0x3f800000bf800000,  // 1.0, -1.0
    0xbff0000047c34fc0)  // -1.0, 99999.5

    push ARG1_64
    push ARG2_64
    movdqu xmm4, XMMWORD PTR [rsp]
    vcvtps2pd ymm0, xmm4
    vcvtps2pd ymm1, xmm2
TEST_END_64

#endif  // HAS_FEATURE_AVX

/* Copyright 2016 Peter Goodman (peter@trailofbits.com), all rights reserved. */

TEST_BEGIN_64(CVTPS2DQv128m128, 2)
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
    cvtps2dq xmm0, XMMWORD PTR [rsp]
TEST_END_64

TEST_BEGIN_64(CVTPS2DQv128v128, 2)
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
    movdqu xmm4, [rsp]
    cvtps2dq xmm0, xmm4
TEST_END_64

#if HAS_FEATURE_AVX

TEST_BEGIN_64(VCVTPS2DQv128m128, 2)
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
    vcvtps2dq xmm0, XMMWORD PTR [rsp]
TEST_END_64

TEST_BEGIN_64(VCVTPS2DQv128v128, 2)
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
    vcvtps2dq xmm0, xmm4
TEST_END_64


TEST_BEGIN_64(VCVTPS2DQv256m256, 2)
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
    push ARG1_64
    push ARG2_64
    vcvtps2dq ymm0, YMMWORD PTR [rsp]
TEST_END_64

TEST_BEGIN_64(VCVTPS2DQv256v256, 2)
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
    push ARG1_64
    push ARG2_64
    vmovdqu ymm4, YMMWORD PTR [rsp]
    vcvtps2dq ymm0, ymm4
TEST_END_64

#endif  // HAS_FEATURE_AVX

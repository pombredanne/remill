/* Copyright 2015 Peter Goodman (peter@trailofbits.com), all rights reserved. */

#include <gflags/gflags.h>
#include <glog/logging.h>

#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <unistd.h>

#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/Support/CommandLine.h>

#include "remill/Arch/Arch.h"
#include "remill/Arch/Name.h"

#include "remill/BC/Lifter.h"
#include "remill/BC/Util.h"

#include "remill/CFG/CFG.h"

#include "remill/OS/FileSystem.h"
#include "remill/OS/OS.h"

#ifndef REMILL_OS
# if defined(__APPLE__)
#   define REMILL_OS "mac"
# elif defined(__linux__)
#   define REMILL_OS "linux"
# endif
#endif

// TODO(pag): Support separate source and target architectures?
DEFINE_string(arch, "", "Architecture of the code being translated. "
                         "Valid architectures: x86, amd64 (with or without "
                         "`_avx` or `_avx512` appended).");

DEFINE_string(os, REMILL_OS, "Source OS. Valid OSes: linux, mac.");

DEFINE_string(cfg, "", "Path to the CFG file containing code to lift.");

DEFINE_string(bc_in, "", "Input bitcode file into which code will "
                         "be lifted. This should either be a semantics file "
                         "associated with `--arch_in`, or it should be "
                         "a bitcode file produced by `remill-lift`. Chaining "
                         "bitcode files produces by `remill-lift` can be "
                         "used to iteratively link in libraries to lifted "
                         "code.");

DEFINE_string(bc_out, "", "Output bitcode file name.");

DEFINE_bool(server, false, "Run the lifter as a server. This will allow "
                           "remill-lift to receive CFG files over time.");

int main(int argc, char *argv[]) {
  std::stringstream ss;
  ss << std::endl << std::endl
     << "  " << argv[0] << " \\" << std::endl
     << "    [--bc_in INPUT_BC_FILE] \\" << std::endl
     << "    --bc_out OUTPUT_BC_FILE \\" << std::endl
     << "    --arch ARCH_NAME \\" << std::endl
     << "    --os OS_NAME \\" << std::endl
     << "    --cfg CFG_FILE \\" << std::endl
     << "    [--server]" << std::endl
     << std::endl;

  google::InitGoogleLogging(argv[0]);
  google::SetUsageMessage(ss.str());
  google::ParseCommandLineFlags(&argc, &argv, true);

  CHECK(!FLAGS_os.empty())
      << "Need to specify a source operating system with --os_in.";

  CHECK(!FLAGS_arch.empty())
      << "Need to specify a source architecture with --arch_in.";


  CHECK(!FLAGS_cfg.empty())
      << "Must specify CFG file with --cfg.";

  CHECK(!FLAGS_bc_out.empty())
      << "Please specify an output bitcode file with --bc_out.";

  auto source_os = remill::GetOSName(FLAGS_os);
  CHECK(remill::kOSInvalid != source_os)
      << "Unsupported operating system for --os_in: " << FLAGS_os;

  auto source_arch_name = remill::GetArchName(FLAGS_arch);
  CHECK(remill::kArchInvalid != source_arch_name)
      << "Unrecognized architecture for --arch_in: " << FLAGS_arch << ".";

  auto source_arch = remill::Arch::Get(source_os, source_arch_name);

  CHECK(remill::FileExists(FLAGS_cfg))
      << "Must specify valid path for --cfg. CFG file "
      << FLAGS_cfg << " cannot be opened.";

  FLAGS_bc_in = remill::FindSemanticsBitcodeFile(FLAGS_bc_in, FLAGS_arch);
  CHECK(remill::FileExists(FLAGS_bc_in))
      << "Must specify valid path for --bc_in. Bitcode file "
      << FLAGS_bc_in << " cannot be opened.";

  do {
    auto context = new llvm::LLVMContext;
    auto module = remill::LoadModuleFromFile(context, FLAGS_bc_in);
    source_arch->PrepareModule(module);

    auto translator = new remill::Lifter(source_arch, module);
    auto cfg = remill::ReadCFG(FLAGS_cfg);
    translator->LiftCFG(cfg);
    delete cfg;
    delete translator;

    remill::StoreModuleToFile(module, FLAGS_bc_out);
    delete module;
    delete context;
  } while (FLAGS_server);

  google::ShutDownCommandLineFlags();
  google::ShutdownGoogleLogging();
  return EXIT_SUCCESS;
}

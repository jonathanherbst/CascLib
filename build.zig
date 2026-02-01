const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const casclib = b.addLibrary(.{ .name = "casc", .linkage = .static, .root_module = b.createModule(.{
        .target = target,
        .optimize = optimize,
    }) });
    casclib.addIncludePath(b.path("src"));
    casclib.addIncludePath(b.path("src/zlib/"));
    casclib.addCSourceFiles(.{ .files = &.{
        "src/common/Common.cpp",
        "src/common/Csv.cpp",
        "src/common/Directory.cpp",
        "src/common/FileStream.cpp",
        "src/common/FileTree.cpp",
        "src/common/ListFile.cpp",
        "src/common/Mime.cpp",
        "src/common/RootHandler.cpp",
        "src/common/Sockets.cpp",
        "src/hashes/md5.cpp",
        "src/hashes/sha1.cpp",
        "src/overwatch/aes.cpp",
        "src/overwatch/apm.cpp",
        "src/overwatch/cmf.cpp",
        "src/CascDecompress.cpp",
        "src/CascDecrypt.cpp",
        "src/CascDumpData.cpp",
        "src/CascFiles.cpp",
        "src/CascFindFile.cpp",
        "src/CascIndexFiles.cpp",
        "src/CascOpenFile.cpp",
        "src/CascOpenStorage.cpp",
        "src/CascReadFile.cpp",
        "src/CascRootFile_Diablo3.cpp",
        "src/CascRootFile_Install.cpp",
        "src/CascRootFile_MNDX.cpp",
        "src/CascRootFile_OW.cpp",
        "src/CascRootFile_Text.cpp",
        "src/CascRootFile_TVFS.cpp",
        "src/CascRootFile_WoW.cpp",
        "src/jenkins/lookup3.c",
        "src/zlib/adler32.c",
        "src/zlib/crc32.c",
        "src/zlib/deflate.c",
        "src/zlib/trees.c",
        "src/zlib/zutil.c",
        "src/zlib/inffast.c",
        "src/zlib/inflate.c",
        "src/zlib/inftrees.c",
    }, .flags = &.{ "-DCASCLIB_NO_AUTO_LINK_LIBRARY", "-DCASCLIB_NODEBUG", "-fno-sanitize=all" } });
    casclib.installHeader(b.path("src/CascLib.h"), "CascLib.h");
    casclib.installHeader(b.path("src/CascPort.h"), "CascPort.h");
    casclib.linkLibC();
    casclib.linkLibCpp();

    b.installArtifact(casclib);
}

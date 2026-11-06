# Homebrew formula for the CKey command-line tool (spec §7: Homebrew is for
# tooling, not a substitute for the Swift package). Generated per release by
# tools/release/make_homebrew_formula.py from the tagged source archive;
# publish it in a tap (e.g. clearkeysolutions/homebrew-tap).
class Ckey < Formula
  desc "Encode, render, print and verify CKey optical codes"
  homepage "https://github.com/clearkeysolutions/ckey"
  url "https://github.com/clearkeysolutions/ckey/archive/refs/tags/v0.1.0-build.83.tar.gz"
  sha256 "d85e25d2b2223e8ada9c6e206ac770b679899d32d014d7a20046380b430333c6"
  version "0.1.0-build.83"
  license "MIT"
  head "https://github.com/clearkeysolutions/ckey.git", branch: "Stable-Release"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCKEY_BUILD_TESTS=OFF", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"ckey", "encode-scalable", "--utf8", "https://openckey.org", "--raster", "t.png", "--size-px", "128"
    assert_predicate testpath/"t.png", :exist?
  end
end

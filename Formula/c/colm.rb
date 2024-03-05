class Colm < Formula
  desc "The Colm Programming Language"
  homepage "https://www.colm.net/open-source/colm/"
  url "https://github.com/adrian-thurston/colm.git",
      tag:      "0.14.7",
      revision: "e88bda068d4a25f2afa7f48821e0f539405c8c6a"
  license "MIT"

  livecheck do
    url :stable
    regex(/^(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on "make" => :build
  depends_on "libtool" => :build
  depends_on "gcc" => :build
  depends_on "g++" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    testfile = testpath/"rubytest.lm"
    testfile.write <<~EOS
      print "hello world\n"
    EOS
    system bin/"colm", "-r", testfile
  end
end

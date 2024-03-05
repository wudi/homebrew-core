class Ragel < Formula
  desc "State machine compiler"
  homepage "https://www.colm.net/open-source/ragel/"
  url "https://github.com/adrian-thurston/ragel.git",
      tag:      "7.0.4",
      revision: "0559d8f0b3e4450b72e8ced99766c32dfc8c9291"
  license "MIT"

  livecheck do
    url :stable
    regex(/^(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on "colm"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}", "--colm-prefix=#{Formula["colm"].opt_prefix}"
    system "make", "install"
  end

  test do
    testfile = testpath/"rubytest.rl"
    testfile.write <<~EOS
      %%{
        machine homebrew_test;
        main := ( 'h' @ { puts "homebrew" }
                | 't' @ { puts "test" }
                )*;
      }%%
        data = 'ht'
        %% write data;
        %% write init;
        %% write exec;
    EOS
    system bin/"ragel", "-s", testfile
  end
end

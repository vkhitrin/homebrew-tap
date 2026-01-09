class LuaAT51 < Formula
  desc "Powerful, lightweight programming language (version 5.1)"
  homepage "https://www.lua.org/"
  url "https://www.lua.org/ftp/lua-5.1.5.tar.gz"
  sha256 "2640fc56a795f29d28ef15e13c34a47e223960b0240e8cb0a82d9b0738695333"
  license "MIT"

  keg_only :versioned_formula

  def install
    system "make", "macosx"
    
    tmp_install = buildpath/"tmp_install"
    system "make", "install", "INSTALL_TOP=#{tmp_install}"
    
    include.install Dir["#{tmp_install}/include/*.h"]
    
    lib.install "#{tmp_install}/lib/liblua.a" => "liblua5.1.a"
    
    cp "#{tmp_install}/bin/lua", "#{tmp_install}/bin/lua5.1"
    cp "#{tmp_install}/bin/lua", "#{tmp_install}/bin/lua-5.1"
    cp "#{tmp_install}/bin/luac", "#{tmp_install}/bin/luac5.1"
    cp "#{tmp_install}/bin/luac", "#{tmp_install}/bin/luac-5.1"
    
    bin.install "#{tmp_install}/bin/lua5.1"
    bin.install "#{tmp_install}/bin/lua-5.1"
    bin.install "#{tmp_install}/bin/luac5.1"
    bin.install "#{tmp_install}/bin/luac-5.1"
    
    cp "#{tmp_install}/man/man1/lua.1", "#{tmp_install}/man/man1/lua5.1.1"
    cp "#{tmp_install}/man/man1/luac.1", "#{tmp_install}/man/man1/luac5.1.1"
    man1.install "#{tmp_install}/man/man1/lua5.1.1"
    man1.install "#{tmp_install}/man/man1/luac5.1.1"

    cd "src" do
      system ENV.cc, "-dynamiclib", "-o", "liblua.5.1.dylib",
             "-all_load", "liblua.a", "-install_name",
             "#{lib}/liblua.5.1.dylib", "-compatibility_version", "5.1",
             "-current_version", "5.1.5", "-lreadline"
      lib.install "liblua.5.1.dylib"
    end

    (lib/"pkgconfig/lua-5.1.pc").write pc_file
  end

  def pc_file
    <<~EOS
      prefix=#{opt_prefix}
      exec_prefix=${prefix}
      libdir=${exec_prefix}/lib
      includedir=${prefix}/include

      Name: Lua
      Description: Powerful, lightweight programming language
      Version: 5.1.5
      Requires:
      Libs: -L${libdir} -llua
      Cflags: -I${includedir}
    EOS
  end

  test do
    system bin/"lua", "-e", "print('Hello, Lua 5.1!')"
    
    (testpath/"test.lua").write <<~EOS
      print(_VERSION)
    EOS
    assert_match "Lua 5.1", shell_output("#{bin}/lua test.lua")
  end
end

require 'formula'

class PltRacket < Formula
  homepage 'http://racket-lang.org/'
  url 'https://github.com/plt/racket/archive/v5.3.6.tar.gz'
  sha256 'aa33ff303a8b7f7fed28a1d78e0a38760c1fe33faf7a1d365ee1ba7d3da1ec11'
  
  def patches
    DATA
  end

  def install
    cd 'src' do
      args = %W[ --disable-debug --disable-dependency-tracking
                 --enable-xonx
                 --prefix=#{prefix}
                 --disable-gracket 
                 --disable-docs ]
                 
      args += '--disable-mac64' unless MacOS.prefer_64_bit?

      ENV['PLT_SETUP_OPTIONS'] = '--workers 1 -l compiler data db dynext ffi file json launcher net openssl pkg planet racket raco reader s-exp setup syntax unstable version xml'
      system "./configure", *args
      system "make"
      ohai "Installing may take a long time (~60 minutes)" unless ARGV.verbose?
      
      system "make install"
    end
  end
end

__END__
diff --git a/src/Makefile.in b/src/Makefile.in
index ce4bac4..5d12d25 100644
--- a/src/Makefile.in
+++ b/src/Makefile.in
@@ -62,7 +62,7 @@ both:

 # Install (common) ----------------------------------------

-SETUP_ARGS = -X @DIRCVTPRE@"$(DESTDIR)$(collectsdir)"@DIRCVTPOST@ -N "raco setup" -l- setup $(PLT_SETUP_OPTIONS) $(PLT_ISO) @INSTALL_SETUP_FLAGS@
+SETUP_ARGS = -X @DIRCVTPRE@"$(DESTDIR)$(collectsdir)"@DIRCVTPOST@ -N "raco setup" -l- setup $(PLT_ISO) @INSTALL_SETUP_FLAGS@ $(PLT_SETUP_OPTIONS)

 # Pass compile and link flags to `make install' for use by any
 #  collection-setup actions that compile and link C code:

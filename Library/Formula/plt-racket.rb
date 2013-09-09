require 'formula'

class PltRacket < Formula
  homepage 'http://racket-lang.org/'
  url 'https://github.com/plt/racket/archive/v5.3.6.tar.gz'
  sha256 'aa33ff303a8b7f7fed28a1d78e0a38760c1fe33faf7a1d365ee1ba7d3da1ec11'
  
  depends_on 'glib'
  depends_on 'cairo'
  depends_on 'pango'
  depends_on 'jpeg'

  def install
    cd 'src' do
      args = %W[ --disable-debug --disable-dependency-tracking
                 --enable-xonx
                 --prefix=#{prefix}
                 --disable-gracket ]
                 
      args += '--disable-mac64' unless MacOS.prefer_64_bit?

      system "./configure", *args
      system "make"
      ohai "Installing may take a long time (~60 minutes)" unless ARGV.verbose?
      
      ENV['PLT_SETUP_OPTIONS'] = '--workers 1' # similar to `ENV.deparallelize`, but acts on the `raco setup` command.
      system "make install"
    end
  end
end

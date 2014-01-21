require 'formula'

class Grenchman < Formula
  homepage 'http://leiningen.org/grench.html'
  url 'https://github.com/technomancy/grenchman/archive/0.2.0.tar.gz'
  sha256 '4b1445df9cc06c28a04f20dfc13331c9b4e85e3e1131618656e1015e5aaaef04'

  head 'https://github.com/technomancy/grenchman.git'

  # We can't use superenv until it and OPAM integrate together better.
  env :std

  depends_on 'opam'
  depends_on 'ocamlfind' => :ocaml
  depends_on 'core' => :ocaml
  depends_on 'async' => :ocaml
  depends_on 'ctypes' => :ocaml

  def install
    system 'ocamlbuild', '-use-ocamlfind', '-lflags', '-cclib,-lreadline', 'grench.native'
    mv 'grench.native', bin/'grench'
  end

  test do
# `test do` will create, run in and delete a temporary directory.
#
# This test will fail and we won't accept that! It's enough to just replace
# "false" with the main program this formula installs, but it'd be nice if you
# were more thorough. Run the test with `brew test grenchman`.
#
# The installed folder is not in the path, so use the entire path to any
# executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

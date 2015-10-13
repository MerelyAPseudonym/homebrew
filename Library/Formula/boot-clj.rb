class BootClj < Formula
  desc "Build tooling for Clojure"
  homepage "http://boot-clj.com"
  url "https://github.com/boot-clj/boot/releases/download/2.2.0/boot.sh",
      :using => :nounzip
  sha256 "2e7d9c501ba3e59ae9f23ce21a8a9f8d24177a346238ee3710f7dd0adbddea33"

  def install
    bin.install "boot.sh" => "boot"
  end

  def post_install
    # Work correctly in sandboxes.
    # (Q.v. <https://github.com/Homebrew/homebrew/pull/44254>)
    ENV["_JAVA_OPTIONS"] = "-Duser.home=#{ENV["HOME"]}"

    # Use the wrapper to update Boot's JAR files too.
    # (Q.v. <https://github.com/boot-clj/boot/tree/2.2.0#install>)
    system bin/"boot", "--update"
  end

  test do
    system "#{bin}/boot", "repl", "-e", "(System/exit 0)"
  end
end

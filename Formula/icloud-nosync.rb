class IcloudNosync < Formula
  desc "Prevent a file or directory from syncing with iCloud"
  homepage "https://github.com/peterbrain/icloud-nosync"
  url "https://github.com/peterbrain/icloud-nosync/archive/refs/tags/0.2.0.tar.gz"
  sha256 "159a50178e25c535a43153610c9a0cf5d35cf757cf88c92f108c8483eca1bdd8"
  license "MIT"

  def install
    bin.install "nosync.sh" => "nosync"
  end

  test do
    (testpath/"testfile").write("This is a test file")

    system "#{bin}/nosync", "testfile"

    assert_predicate testpath/"testfile.nosync", :exist?, "The .nosync file should exist"
    assert_predicate testpath/"testfile", :symlink?, "The original file should be a symlink"
  end
end

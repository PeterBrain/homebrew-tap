class IcloudNosync < Formula
  desc "Prevent a file or directory from syncing with iCloud"
  homepage "https://github.com/peterbrain/icloud-nosync"
  url "https://github.com/peterbrain/icloud-nosync/archive/refs/tags/0.2.2.tar.gz"
  sha256 "d3d76589e3f38ba5bb7701c8d5799550e0824cf837b2a7868c61a60ef268dc7a"
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

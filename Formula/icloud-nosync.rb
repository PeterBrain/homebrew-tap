class IcloudNosync < Formula
  desc "Prevent a file or directory from syncing with iCloud"
  homepage "https://github.com/peterbrain/icloud-nosync"
  url "https://github.com/peterbrain/icloud-nosync/archive/refs/tags/0.1.1.tar.gz"
  sha256 "2fcfa2a61bce8beba29b732c41ec05c1ecfbe80149cb8b43d401f5f8a3770539"
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

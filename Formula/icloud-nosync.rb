class IcloudNosync < Formula
  desc "Prevent a file or directory from syncing with iCloud"
  homepage "https://github.com/peterbrain/icloud-nosync"
  url "https://github.com/peterbrain/icloud-nosync/archive/refs/tags/0.2.1.tar.gz"
  sha256 "30f04bd37b3c6f7381ee9276266ab41f95054552fcbe7813bb2de921d455490b"
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

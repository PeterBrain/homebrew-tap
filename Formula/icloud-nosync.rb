class IcloudNosync < Formula
  desc "Prevent a file or directory from syncing with iCloud"
  homepage "https://github.com/peterbrain/icloud-nosync"
  url "https://github.com/peterbrain/icloud-nosync/archive/refs/tags/0.2.3.tar.gz"
  sha256 "2118c8ec5e8c1b8233e68a74c6ab251c43abb8f83f37a6c2b8aaa10a65f230be"
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

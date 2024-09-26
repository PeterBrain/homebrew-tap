class IcloudNosync < Formula
  desc "Prevent a file or directory from syncing with iCloud"
  homepage "https://github.com/peterbrain/icloud-nosync"
  url "https://github.com/peterbrain/icloud-nosync/archive/refs/tags/0.2.3.tar.gz"
  sha256 "2118c8ec5e8c1b8233e68a74c6ab251c43abb8f83f37a6c2b8aaa10a65f230be"
  license "MIT"
  head "https://github.com/peterbrain/icloud-nosync.git", branch: "main"

  depends_on "git" => :optional
  depends_on :macos

  def install
    bin.install "nosync.sh" => "nosync"

    (prefix/"workflows").install Dir["workflows/*"]

    ohai "iCloud-noSync installed successfully!"
  end

  def caveats
    <<~EOS
      To install the Finder Quick Actions (workflows), run the following command:

        cp -r #{prefix}/workflows/* ~/Library/Services/

      This may require elevated permissions to be copied to ~/Library/Services.

      Then, enable the workflows in Finder by following the instructions here:
      https://support.apple.com/guide/automator/use-quick-action-workflows-aut73234890a/mac#aut067d4e77d

      If you are using the HEAD version, you may want to run:
        brew link --overwrite icloud-nosync
      to ensure the latest version is properly linked.
    EOS
  end

  test do
    (testpath/"testfile").write("This is a test file")

    # test adding .nosync
    system "#{bin}/nosync", "testfile"
    assert_predicate testpath/"testfile.nosync", :exist?, "The .nosync file should exist"
    assert_predicate testpath/"testfile", :symlink?, "The original file should be a symlink"

    # test removing .nosync
    system "#{bin}/nosync", "--undo", "testfile"
    refute_predicate testpath/"testfile.nosync", :exist?, "The .nosync file should not exist after undoing"
    assert_predicate testpath/"testfile", :exist?, "The file should exist after undoing"
    refute_predicate testpath/"testfile", :symlink?, "The file should not be a symlink"
  end
end

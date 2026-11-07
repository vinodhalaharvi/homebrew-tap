class Collage < Formula
  desc "Arrange photos into a gap-free collage of any shape"
  homepage "https://github.com/vinodhalaharvi/collage"
  url "https://github.com/vinodhalaharvi/collage/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "820d90591e39e602ced6c6f653fbaa7903e3e75fa68d73b19e2e5b4b651906a0"
  license "MIT"
  head "https://github.com/vinodhalaharvi/collage.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/collage"
  end

  test do
    assert_match "equal", shell_output("#{bin}/collage laws")
    assert_match version.to_s, shell_output("#{bin}/collage version")
  end
end

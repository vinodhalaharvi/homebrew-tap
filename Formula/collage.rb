class Collage < Formula
  desc "Arrange photos into a gap-free collage of any shape"
  homepage "https://github.com/vinodhalaharvi/collage"
  url "https://github.com/vinodhalaharvi/collage/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "ed30647ba1a71a15daf37f596b3ad2a71fd4ecdeea089ebce607ff5d012fee42"
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

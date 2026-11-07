class Collage < Formula
  desc "Arrange photos into a gap-free collage of any shape"
  homepage "https://github.com/vinodhalaharvi/collage"
  url "https://github.com/vinodhalaharvi/collage/archive/d009bb3f7968b43edd56e02746323db118fb3787.tar.gz"
  version "0.1.0"
  sha256 "684fa8514893198f719dd9d04ade84629c5cbe54227985f40deb194bd28830ee"
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

class Camwall < Formula
  desc "Every camera feed on one gap-free wall, in a browser or as one stream"
  homepage "https://github.com/vinodhalaharvi/camwall"
  url "https://github.com/vinodhalaharvi/camwall/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "36f97a871bcdabaf85ea7965d76716e95497970de75634532d2675d28ff1ea36"
  license "MIT"
  head "https://github.com/vinodhalaharvi/camwall.git", branch: "main"

  depends_on "go" => :build
  depends_on "ffmpeg"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/camwall"
  end

  test do
    assert_match "equal", shell_output("#{bin}/camwall laws")
    assert_match version.to_s, shell_output("#{bin}/camwall version")
  end
end

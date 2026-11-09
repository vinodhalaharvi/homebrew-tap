class Camwall < Formula
  desc "Every camera feed on one gap-free wall, in a browser or as one stream"
  homepage "https://github.com/vinodhalaharvi/camwall"
  url "https://github.com/vinodhalaharvi/camwall/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "dbed5abf9e4b50bf0c9089820a6010ab9033af1adcecbe83a75f697ca4b45459"
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

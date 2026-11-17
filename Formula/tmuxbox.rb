class Tmuxbox < Formula
  desc "Your tmux panes on a bean in the browser, with a terminal joined to the one you pick"
  homepage "https://github.com/vinodhalaharvi/tmuxbox"
  url "https://github.com/vinodhalaharvi/tmuxbox/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "536e694060f0edf9296f81a0e155c9cf0a5523e62d4cbd7f0179808b1a21811b"
  head "https://github.com/vinodhalaharvi/tmuxbox.git", branch: "main"

  depends_on "go" => :build
  depends_on "tmux"

  def install
    # The page inside the binary loads the layout solver as WebAssembly,
    # which is built first.
    system "make", "web"
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/tmuxbox"
  end

  test do
    assert_match "tmuxbox v#{version}", shell_output("#{bin}/tmuxbox -version")
  end
end

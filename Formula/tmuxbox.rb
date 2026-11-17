class Tmuxbox < Formula
  desc "Your tmux panes on a bean in the browser, with a terminal joined to the one you pick"
  homepage "https://github.com/vinodhalaharvi/tmuxbox"
  url "https://github.com/vinodhalaharvi/tmuxbox/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "a1a8e59071dcb042f94ac84e587ad86cd1beb62aaf159fa3c65f618b20f3aede"
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

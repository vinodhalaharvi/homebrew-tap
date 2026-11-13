class Tilegen < Formula
  desc "Compile a small spec into Go scaffolding, leaving precise holes for an LLM"
  homepage "https://github.com/vinodhalaharvi/tilegen"
  url "https://github.com/vinodhalaharvi/tilegen/archive/refs/tags/v0.3.3.tar.gz"
  sha256 "959538a6426ef691ba7bc35f0d49ff714aad722994847db525a0d57d3b04ea88"
  license "MIT"
  head "https://github.com/vinodhalaharvi/tilegen.git", branch: "main"

  # Go is needed to run tilegen as well as to build it: it asks the go
  # command about the standard library, and what it generates is Go.
  depends_on "go"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    assert_match "tilegen v#{version}", shell_output("#{bin}/tilegen -version")
    (testpath/"spec.sexp").write <<~EOS
      (project p (module example.com/p) (go 1.22)
        (package notes
          (entity Note (field ID int64) (field Body string)
            (store get save (durable)))))
    EOS
    assert_match "chosen  sqlite-sqlc", shell_output("#{bin}/tilegen explain #{testpath}/spec.sexp")
  end
end

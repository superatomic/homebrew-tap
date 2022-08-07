class Xshe < Formula
  desc "Cross-shell environment variables manager"
  homepage "https://xshe.superatomic.dev"
  url "https://github.com/superatomic/xshe/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "5d34bf5ec6c067b6d60f907da8727d862d39e4ba35bc26d75e78bec10b283100"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/superatomic/xshe.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    out_dir = Dir["target/release/build/xshe-*/out"].first
    man1.install out_dir/"xshe.1"
    bash_completion.install out_dir/"xshe.bash"
    zsh_completion.install out_dir/"_xshe"
    fish_completion.install out_dir/"xshe.fish"
  end

  test do
    system bin/"xshe", "bash", "-t", "HELLO = 'World'"
  end
end

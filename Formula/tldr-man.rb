class TldrMan < Formula
  include Language::Python::Virtualenv

  desc "Command-line TLDR client that displays tldr-pages as manpages"
  homepage "https://tldr-man.superatomic.dev"
  url "https://files.pythonhosted.org/packages/20/46/67a85c64788d64011c83676974993b582295cfea31eedb224a345d48c0f4/tldr_man-1.4.1.tar.gz"
  sha256 "b194ffa8354e97c73e90f9f7bef7433b7f0a9bdf2f84d6c5142df713a8d1a8b1"
  license "Apache-2.0"
  head "https://github.com/superatomic/tldr-man.git", branch: "main"

  depends_on "poetry" => :build
  depends_on "pandoc"
  depends_on "python@3.11"

  conflicts_with "homebrew/core/tldr", "homebrew/core/tealdeer", because: "both install `tldr` binaries"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/98/98/c2ff18671db109c9f10ed27f5ef610ae05b73bd876664139cf95bd1429aa/certifi-2023.7.22.tar.gz"
    sha256 "539cc1d13202e33ca466e88b2807e29f4c13049d6d87031a3c110744495cb082"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/2a/53/cf0a48de1bdcf6ff6e1c9a023f5f523dfe303e4024f216feac64b6eb7f67/charset-normalizer-3.2.0.tar.gz"
    sha256 "3bb3d25a8e6c0aedd251753a79ae98a093c7e7b471faa3aa9a93a81431987ace"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "click-help-colors" do
    url "https://files.pythonhosted.org/packages/a8/5a/e38178c3fd7bb0a0f143ed5291f7f80d391431f262db5a5e16e7d8f34046/click-help-colors-0.9.2.tar.gz"
    sha256 "756245e542d29226bb3bc056bfa58886f212ba2b82f4e8cf5fc884176ac96d72"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/9d/be/10918a2eac4ae9f02f6cfe6414b7a155ccd8f7f9d4380d62fd5b955065c3/requests-2.31.0.tar.gz"
    sha256 "942c5a758f98d790eaed1a29cb6eefc7ffb0d1cf7af05c3d2791656dbd6ad1e1"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/31/ab/46bec149bbd71a4467a3063ac22f4486ecd2ceb70ae8c70d5d8e4c2a7946/urllib3-2.0.4.tar.gz"
    sha256 "8d22f86aae8ef5e410d4f539fde9ce6b2113a001bb4d189e0aed70642d602b11"
  end

  def install
    virtualenv_install_with_resources

    # Install shell completions
    ENV.prepend_path "PATH", bin
    system "./generate_completions.sh"
    cd "completions" do
      bash_completion.install "tldr.bash", "tldr-man.bash"
      zsh_completion.install "tldr.zsh" => "_tldr", "tldr-man.zsh" => "_tldr-man"
      fish_completion.install "tldr.fish", "tldr-man.fish"
    end

    # Install manual pages
    man1.install "tldr-man.1"
    man1.install_symlink "tldr-man.1" => "tldr.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tldr --version")
  end
end

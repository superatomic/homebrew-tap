class TldrMan < Formula
  include Language::Python::Virtualenv

  desc "Command-line TLDR client that displays tldr-pages as manpages"
  homepage "https://tldr-man.superatomic.dev"
  url "https://files.pythonhosted.org/packages/15/5d/4ebb7c0d2b051a7c21d4865c42318405a6badad292c00c18d668bfdc2dbd/tldr_man-1.5.0.tar.gz"
  sha256 "7ea88d108dd46a4469e598b1bb77b1006ff85db9a8d5523535dfc57a4cab245d"
  license "Apache-2.0"
  head "https://github.com/superatomic/tldr-man.git", branch: "main"

  depends_on "poetry" => :build
  depends_on "pandoc"
  depends_on "python@3.11"

  conflicts_with "homebrew/core/tldr", "homebrew/core/tealdeer", because: "both install `tldr` binaries"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/d4/91/c89518dd4fe1f3a4e3f6ab7ff23cb00ef2e8c9adf99dacc618ad5e068e28/certifi-2023.11.17.tar.gz"
    sha256 "9b469f3a900bf28dc19b8cfbf8019bf47f7fdd1a65a1d4ffb98fc14166beb4d1"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/63/09/c1bc53dab74b1816a00d8d030de5bf98f724c52c1635e07681d312f20be8/charset-normalizer-3.3.2.tar.gz"
    sha256 "f30c3cb33b24454a82faecaf01b19c18562b1e89558fb6c56de4d9118a032fd5"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "click-help-colors" do
    url "https://files.pythonhosted.org/packages/6f/50/76f51d9c7fcd72a12da466801f7c1fa3884424c947787333c74327b4fcf3/click-help-colors-0.9.4.tar.gz"
    sha256 "f4cabe52cf550299b8888f4f2ee4c5f359ac27e33bcfe4d61db47785a5cc936c"
  end

  resource "filelock" do
    url "https://files.pythonhosted.org/packages/70/70/41905c80dcfe71b22fb06827b8eae65781783d4a14194bce79d16a013263/filelock-3.13.1.tar.gz"
    sha256 "521f5f56c50f8426f5e03ad3b281b490a87ef15bc6c526f168290f0c7148d44e"
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
    url "https://files.pythonhosted.org/packages/36/dd/a6b232f449e1bc71802a5b7950dc3675d32c6dbc2a1bd6d71f065551adb6/urllib3-2.1.0.tar.gz"
    sha256 "df7aa8afb0148fa78488e7899b2c59b5f4ffcfa82e6c54ccb9dd37c1d7b52d54"
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

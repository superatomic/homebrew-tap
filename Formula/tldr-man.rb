class TldrMan < Formula
  include Language::Python::Virtualenv

  desc "Command-line TLDR client that displays tldr-pages as manpages"
  homepage "https://tldr-man.superatomic.dev"
  url "https://files.pythonhosted.org/packages/a7/4c/d4745dc09bc6795e9beaf0b467c1045b301085550f73e434db13dca691ac/tldr_man-1.1.0.tar.gz"
  sha256 "fcca02a831f796abfced76032dca4f9cd195e9ffd408ab83daa9ae6499ddf550"
  license "Apache-2.0"
  head "https://github.com/superatomic/tldr-man-client.git", branch: "main"

  depends_on "poetry" => :build
  depends_on "pandoc"
  depends_on "python@3.10"

  conflicts_with "homebrew/core/tldr", "homebrew/core/tealdeer", because: "both install `tldr` binaries"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/37/f7/2b1b0ec44fdc30a3d31dfebe52226be9ddc40cd6c0f34ffc8923ba423b69/certifi-2022.12.7.tar.gz"
    sha256 "35824b4c3a97115964b408844d64aa14db1cc518f6562e8d7261699d1350a9e3"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/ff/d7/8d757f8bd45be079d76309248845a04f09619a7b17d6dfc8c9ff6433cac2/charset-normalizer-3.1.0.tar.gz"
    sha256 "34e0a2f9c370eb95597aae63bf85eb5e96826d81e3dcf88b8886012906f509b5"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/59/87/84326af34517fca8c58418d148f2403df25303e02736832403587318e9e8/click-8.1.3.tar.gz"
    sha256 "7682dc8afb30297001674575ea00d1814d808d6a36af415a82bd481d37ba7b8e"
  end

  resource "click-help-colors" do
    url "https://files.pythonhosted.org/packages/6c/c1/abc07420cfdc046c1005e16bc8090bc1f226d631b2bd172e5a8f5524c127/click-help-colors-0.9.1.tar.gz"
    sha256 "78cbcf30cfa81c5fc2a52f49220121e1a8190cd19197d9245997605d3405824d"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/9d/ee/391076f5937f0a8cdf5e53b701ffc91753e87b07d66bae4a09aa671897bf/requests-2.28.2.tar.gz"
    sha256 "98b1b2782e3c6c4904938b84c0eb932721069dfdb9134313beff7c83c2df24bf"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/21/79/6372d8c0d0641b4072889f3ff84f279b738cd8595b64c8e0496d4e848122/urllib3-1.26.15.tar.gz"
    sha256 "8a388717b9476f934a21484e8c8e61875ab60644d29b9b39e11e4b9dc1c6b305"
  end

  resource "xdg" do
    url "https://files.pythonhosted.org/packages/33/fe/67bc1f8ee2782bca3cdc63558a64f843bb9f88e15793475350809fbd8e01/xdg-5.1.1.tar.gz"
    sha256 "aa619f26ccec6088b2a6018721d4ee86e602099b24644a90a8d3308a25acd06c"
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
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tldr --version")
  end
end

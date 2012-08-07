require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Runkit < AbstractPhpExtension
  homepage 'https://github.com/zenovich/runkit'
  # There's no tag set for this version, but there is an explicit download
  url 'https://github.com/downloads/zenovich/runkit/runkit-1.0.3.tgz'
  md5 '3b40c9285ec8c146723426075282d798'
  version '1.0.3'

  depends_on 'autoconf' => :build
  depends_on 'php53' if ARGV.include?('--with-homebrew-php') && !Formula.factory('php53').installed?

  def install
    Dir.chdir "runkit-#{version}" unless ARGV.build_head?

    # See https://github.com/mxcl/homebrew/pull/5947
    ENV.universal_binary

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--enable-runkit"
    system "make"
    prefix.install "modules/runkit.so"
    write_config_file unless ARGV.include? "--without-config-file"
  end
end

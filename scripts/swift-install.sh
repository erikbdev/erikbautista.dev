if swift --version &> /dev/null; then
  echo "Swift is currently installed, skipping installation.";
else
  echo "warning: Swift is not installed, installing swiftly to install latest Swift toolchain.";
  curl -L https://swift-server.github.io/swiftly/swiftly-install.sh | bash -s -- -y
  . $HOME/.local/share/swiftly/env.sh
  swiftly install latest
  echo $PATH
  ls -la $HOME/.local/bin
  ls -la $HOME/.local/share/swiftly/toolchains
  export PATH=$HOME/.local/bin:$PATH
fi
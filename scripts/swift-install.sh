if swift --version &> /dev/null; then
  echo "Swift is currently installed, skipping installation."
  export SWIFT_BIN=$(which swift)
else
  echo "warning: Swift is not installed, installing swiftly to install latest Swift toolchain.";
  curl -L https://swift-server.github.io/swiftly/swiftly-install.sh | bash -s -- -y
  . $HOME/.local/share/swiftly/env.sh
  swiftly install latest
  echo $PATH
  ls -la $HOME/.local/bin
  export SWIFT_BIN=$HOME/.local/bin/swift
fi
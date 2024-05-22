if swift --version &> /dev/null; then
  echo "Swift is currently installed, skipping installation.";
else
  echo "warning: Swift is not installed, installing swiftly to install latest Swift version.";
  curl -L https://swift-server.github.io/swiftly/swiftly-install.sh | bash -s -- -y
  . $HOME/.local/share/swiftly/env.sh
  swiftly install latest
fi
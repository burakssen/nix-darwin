cask "quitme" do
  version "1.1.1"
  sha256 :no_check  # We're building from source, so no need to check a zip file

  url "https://github.com/burakssen/QuitMe.git",
      tag:      "v#{version}",
      verified: "github.com/burakssen/QuitMe"
  name "QuitMe"
  desc "A brief description of QuitMe"
  homepage "https://github.com/burakssen/QuitMe"

  depends_on macos: ">= :big_sur"  # Adjust minimum macOS version if needed

  # Build the app from source with ad-hoc signing
  preflight do
    system_command "xcodebuild",
                   args: [
                     "-project", "#{staged_path}/QuitMe.xcodeproj",  # or QuitMe.xcworkspace if using workspace
                     "-scheme", "QuitMe",
                     "-configuration", "Release",
                     "-derivedDataPath", "#{staged_path}/build",
                     "CONFIGURATION_BUILD_DIR=#{staged_path}",
                     "CODE_SIGN_IDENTITY=-",
                     "CODE_SIGN_STYLE=Manual",
                     "DEVELOPMENT_TEAM=",
                   ]
  end

  app "QuitMe.app"

  uninstall quit: "com.burakssen.QuitMe"
  
  zap trash: [
    "~/Library/Application Support/QuitMe",
    "~/Library/Preferences/com.burakssen.QuitMe.plist",
  ]
end

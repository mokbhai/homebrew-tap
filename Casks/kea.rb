cask "kea" do
  version "0.5.2"
  sha256 "c1bd3cdb566597b3aa1bd4b1df8a40d6a11ac600a6c742fc7344601d1aae2b84"

  url "https://github.com/mokbhai/KEA/releases/download/v#{version}/KEA_#{version}_aarch64.dmg"
  name "KEA"
  desc "AI rewrite, dictation, meeting notes and text-to-speech"
  homepage "https://github.com/mokbhai/KEA"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on :macos

  app "KEA.app"

  # The release build is not notarized, so Gatekeeper would refuse to open a
  # quarantined copy. Clearing the flag is what a user would otherwise do by
  # hand from System Settings.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/KEA.app"], must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/ai.kea.app",
    "~/Library/Application Support/ai.kea.desktop",
    "~/Library/Caches/ai.kea.app",
    "~/Library/Caches/ai.kea.desktop",
    "~/Library/Logs/ai.kea.app",
    "~/Library/Logs/ai.kea.desktop",
    "~/Library/Preferences/ai.kea.desktop.plist",
    "~/Library/WebKit/ai.kea.app",
    "~/Library/WebKit/ai.kea.desktop",
  ]

  caveats <<~EOS
    KEA needs Accessibility and Microphone permission. macOS asks for them the
    first time you use dictation or hold-to-talk.
  EOS
end

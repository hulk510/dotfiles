#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi
# 自分でやる必要があるもの
# - ライブ変換のオフ
# - mission controlのキーボードショートカット
# - バッテリー設定でディスプレイの表示時間を15分に
# - マウスのスクロールスピードの修正
# いくつか再起動しないと反映されないときもある

# ====================
#
# Base
#
# ====================

# Disable auto-capitalization 自動大文字の無効化
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# キーのリピート速度
defaults write NSGlobalDomain KeyRepeat -int 6
# リピート入力認識までの時間
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# キーボードの入力ソースがU.S. or ABCの場合でも長押しでキーリピートになるように
# そもそも日本語入力で英字も入力できるため別にいらないかも
# defaults write -g ApplePressAndHoldEnabled -bool true

# クラッシュレポートの無効化
defaults write com.apple.CrashReporter DialogType -string "none"

# スクロールバーの表示タイミング
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# 起動時に前回開いたウィンドウを開かない
defaults write com.apple.Preview NSQuitAlwaysKeepsWindows -bool false

# ====================
#
# Dock
#
# ====================

# Automatically hide or show the Dock （Dock を自動的に隠す）
defaults write com.apple.dock autohide -bool true

# Wipe all app icons from the Dock （Dock に標準で入っている全てのアプリを消す、Finder とごみ箱は消えない）
defaults write com.apple.dock persistent-apps -array

# Magnificate the Dock （Dock の拡大機能を入にする）
defaults write com.apple.dock magnification -bool true

# Disable animation at application launch
defaults write com.apple.dock launchanim -bool false

# 拡大時のサイズ (最大: 128)
defaults write com.apple.dock largesize -int 108

# Dockを自動的に隠す
defaults write com.apple.dock autohide -bool true

# ====================
#
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
#
# ====================

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# Trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 0

# マウスの軌道の速さ
defaults write NSGlobalDomain com.apple.mouse.scaling 0.875

# ====================
#
# Finder
#
# ====================

# アニメーションを無効化する
defaults write com.apple.finder DisableAllAnimations -bool true

# デフォルトで隠しファイルを表示する
defaults write com.apple.finder AppleShowAllFiles -bool true

# 全ての拡張子のファイルを表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# ステータスバーを表示
defaults write com.apple.finder ShowStatusBar -bool true

# パスバーを表示
defaults write com.apple.finder ShowPathbar -bool true

# 名前で並べ替えを選択時にディレクトリを前に置くようにする
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# 検索時にデフォルトでカレントディレクトリを検索
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# CapsLock を Ctrl に変更する
# get string like : 1452-630-0 for keyboard_id (ref: http://freewing.starfree.jp/software/macos_keyboard_setting_terminal_commandline)
keyboard_id="$(ioreg -c AppleEmbeddedKeyboard -r | grep -Eiw "VendorID|ProductID" | awk '{ print $4 }' | paste -s -d'-\n' -)-0"
defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboard_id} -array-add "
<dict>
  <key>HIDKeyboardModifierMappingDst</key>\
  <integer>30064771300</integer>\
  <key>HIDKeyboardModifierMappingSrc</key>\
  <integer>30064771129</integer>\
</dict>
"

# スペルの訂正を有効
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool true


# ====================
#
# SystemUIServer
#
# ====================

# Display date, day, and time in the menu bar
# 日付と時刻
# メニューバーに日付、曜日、24時間、秒数を表示）
defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM HH:mm:ss'

# Display battery level in the menu bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# ====================
#
# Safari
#
# ====================

# Safariのデバッグメニューを有効化
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# 自動修正の無効化
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false
for app in "Dock" \
	"Finder" \
	"SystemUIServer" \
  "Safari"; do
	killall "${app}" &> /dev/null
done

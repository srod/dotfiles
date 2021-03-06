#!/bin/bash

print_in_blue "\n   Finder\n\n"

execute "defaults write com.apple.finder _FXShowPosixPathInTitle -bool true" \
    "Use full POSIX path as window title"

execute "defaults write com.apple.finder _FXSortFoldersFirst -bool true" \
    "Keep folders on top when sorting by name"

execute "defaults write com.apple.finder DisableAllAnimations -bool true" \
    "Disable all animations"

execute "defaults write com.apple.finder WarnOnEmptyTrash -bool false" \
    "Disable the warning before emptying the Trash"

execute "defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'" \
    "Search the current directory by default"

execute "defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false" \
    "Disable warning when changing a file extension"

execute "defaults write com.apple.finder FXPreferredViewStyle -string 'Nlsv'" \
    "Use list view in all Finder windows by default"

execute "defaults write com.apple.finder NewWindowTarget -string 'PfLo' && \
         defaults write com.apple.finder NewWindowTargetPath -string 'file://$HOME'" \
    "Set 'Home' as the default location for new Finder windows"

execute "defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false && \
         defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false && \
         defaults write com.apple.finder ShowMountedServersOnDesktop -bool false && \
         defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false" \
    "Hide icons for hard drives, servers, and removable media on the desktop"

execute "defaults write com.apple.finder ShowRecentTags -bool false" \
    "Do not show recent tags"

execute "defaults write -g AppleShowAllExtensions -bool true" \
    "Show all filename extensions"

execute "defaults write com.apple.finder ShowStatusBar -bool true" \
    "Show status bar"

execute "defaults write com.apple.finder ShowPathbar -bool true" \
    "Show path bar"

execute "defaults write NSGlobalDomain com.apple.springing.enabled -bool true" \
    "Enable spring loading for directories"

execute "defaults write NSGlobalDomain com.apple.springing.delay -float 0" \
    "Remove the spring loading delay for directories"

execute "defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true && \
         defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true" \
    "Avoid creating .DS_Store files on network or USB volumes"

execute "defaults write com.apple.frameworks.diskimages skip-verify -bool true && \
         defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true && \
         defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true" \
    "Disable disk image verification"

execute "chflags nohidden ~/Library" \
    "Show the ~/Library folder"

execute "sudo chflags nohidden /Volumes" \
    "Show the /Volumes folder"

execute "defaults write com.apple.finder FXInfoPanesExpanded -dict \
         General -bool true \
         OpenWith -bool true \
         Privileges -bool true" \
    "Expand the following File Info panes: “General”, “Open with”, and “Sharing & Permissions”"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:iconSize 72' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:iconSize 72' ~/Library/Preferences/com.apple.finder.plist" \
    "Set icon size"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:gridSpacing 1' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:gridSpacing 1' ~/Library/Preferences/com.apple.finder.plist" \
    "Set icon grid spacing size"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:textSize 13' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:textSize 13' ~/Library/Preferences/com.apple.finder.plist" \
    "Set icon label text size"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:labelOnBottom true' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:labelOnBottom true' ~/Library/Preferences/com.apple.finder.plist" \
    "Set icon label position"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:showItemInfo true' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:showItemInfo true' ~/Library/Preferences/com.apple.finder.plist" \
    "Show item info"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:arrangeBy none' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:arrangeBy none' ~/Library/Preferences/com.apple.finder.plist" \
    "Set sort method"

killall "Finder" &> /dev/null

# Starting with Mac OS X Mavericks preferences are cached,
# so in order for things to get properly set using `PlistBuddy`,
# the `cfprefsd` process also needs to be killed.
#
# https://github.com/alrra/dotfiles/commit/035dda057ddc6013ba21db3d2c30eeb51ba8f200

killall "cfprefsd" &> /dev/null

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Kanmoku-Support' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'NXDrawKit'


  # Pods for Kanmoku-Support

  target 'Kanmoku-SupportTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Kanmoku-SupportUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do | installer |
  require 'fileutils'
  FileUtils.cp_r('Pods/Target Support Files/Pods-Kanmoku-Support/Pods-Kanmoku-Support-Acknowledgements.plist', 'Kanmoku-Support/Settings.bundle/Acknowledgements.plist', :remove_destination => true)
end

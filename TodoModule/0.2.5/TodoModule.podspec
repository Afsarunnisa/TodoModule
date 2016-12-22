Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "TodoModule"
s.summary = "TodoModule "
s.requires_arc = true

# 2
s.version = "0.2.5"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Afsara" => "afsarunnisa@wavelabs.in" }


# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/Afsarunnisa/TodoModule"

# For example,
# s.homepage = "https://github.com/JRG-Developer/RWPickFlavor"


# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/Afsarunnisa/TodoModule.git", :tag => "#{s.version}"}

# For example,
# s.source = { :git => "https://github.com/JRG-Developer/RWPickFlavor.git", :tag => "#{s.version}"}


# 7
s.framework = "UIKit"

# 8
s.source_files = "TodoModule/**/*.{swift}"

# 9
s.resources = "TodoModule/**/*.{png,jpeg,jpg,storyboard,xib,plist}"
end

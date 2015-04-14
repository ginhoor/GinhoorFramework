Pod::Spec.new do |s|
  s.name         = "GinhoorFramework"
  s.version      = "0.0.4"
  s.summary      = "This is one of my personal library."
  s.requires_arc = true

  s.homepage     = "https://github.com/ginhoor/GinhoorFramework"
  s.license      = "MIT"
  s.author             = { "JunhuaShao" => "ginhoor@gmail.com" }

  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/ginhoor/GinhoorFramework.git", :tag => s.version.to_s }
  # s.source_files  = "*.{h,m}"


  # s.resource  = "icon.png"
  # s.resources = "GinFramework/Framework/**/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  s.frameworks = "Foundation", "CoreGraphics", "UIKit"
  # s.library   = "libxml2"
  # s.libraries = "iconv", "xml2"


  # 依赖库
  s.dependency 'BlocksKit', '~> 2.2.5' 
  s.dependency 'Masonry', '~> 0.6.1'
  s.dependency 'AFNetworking', '~> 2.5.1'
  s.dependency 'CocoaLumberjack', '~> 2.0.0'
  s.dependency 'libextobjc', '~> 0.4.1'

  s.subspec 'GinSysInfo' do |ss|
    ss.source_files = 'GinSysInfo/*.{h,m}','GinSysInfo/**/*.{h,m}','GinSysInfo/**/**/*.{h,m}'
  end

  s.subspec 'Category' do |ss|
    ss.dependency 'GinhoorFramework/GinSysInfo'
    ss.source_files = 'Category/**/*.{h,m}','Category/**/**/*.{h,m}','Category/**/**/**/*.{h,m}','Category/**/**/**/**/*.{h,m}'
  end

  s.subspec 'CustomView' do |ss|
    ss.dependency 'GinhoorFramework/GinSysInfo'
    ss.dependency 'GinhoorFramework/Category'
    ss.source_files = 'CustomView/**/*.{h,m}','CustomView/**/**/*.{h,m}'
  end

  s.subspec 'CustomViewController' do |ss|
    ss.dependency 'GinhoorFramework/GinSysInfo'
    ss.dependency 'GinhoorFramework/Category'
    ss.source_files = 'CustomViewController/**/*.{h,m}','CustomViewController/**/**/*.{h,m}'
  end
end

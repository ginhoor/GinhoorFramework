Pod::Spec.new do |s|
    s.name         = "GinhoorFramework"
    s.version      = "1.4.6" # 被应用次数.大版本号.开发版本号
    s.summary      = "This is one of my personal library."
    s.homepage     = "https://github.com/ginhoor/GinhoorFramework"
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { "JunhuaShao" => "ginhoor@gmail.com" }

    s.requires_arc = true
    s.platform     = :ios, "7.0"

    s.source       = { :git => "https://github.com/ginhoor/GinhoorFramework.git", :tag => s.version.to_s }
#    s.source_files  = "GinhoorFramework.h"

# s.public_header_files = 'GinhoorFramework/GinhoorFramework.h'

    # 用来指定外部的静态库
    # s.vendored_libraries = ''


    # s.resource  = "icon.png"
    # s.resources = "GinFramework/Framework/**/*.png"
    # 表示需要保留的文件路径
    # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

    s.frameworks = "Foundation", "CoreGraphics", "UIKit", "AddressBook", "AddressBookUI"

    # s.library   = "libxml2"
    # s.libraries = "iconv", "xml2"

    s.subspec 'GinSysInfo' do |ss|
        ss.source_files = 'GinSysInfo/*.{h,m}'
    end

    s.subspec 'Category' do |ss|
        ss.dependency 'GinhoorFramework/GinSysInfo'
        ss.dependency 'BlocksKit', '~> 2.2.5'
        ss.dependency 'MJRefresh', '~> 3.1.12'

        ss.source_files = 'Category/**/*.{h,m}',
                          'Category/**/**/*.{h,m}'
    end

    s.subspec 'Debug' do |ss|
        ss.source_files = 'Debug/*.{h,m}'
    end

    s.subspec 'Tools' do |ss|
        ss.dependency 'BlocksKit', '~> 2.2.5'
        ss.dependency 'GinhoorFramework/GinSysInfo'
        ss.dependency 'GinhoorFramework/Category'

    ss.source_files = 'Tools/**/*.{h,m}'
    end

#   s.subspec 'CustomView' do |ss|
#    ss.dependency 'GinhoorFramework/GinSysInfo'
#    ss.dependency 'GinhoorFramework/Category'
#   ss.source_files =   'CustomView/**/*.{h,m}',
#
#   ss.resources =  "CustomView/**/**/*.png",
#
#   end

end

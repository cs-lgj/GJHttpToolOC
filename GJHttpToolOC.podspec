
Pod::Spec.new do |s|
  s.name             = 'GJHttpToolOC'
  s.version          = '0.1.3'
  s.summary          = 'Objective-C 网络请求框架，封装自AFNetworking'

  s.description      = <<-DESC
Objective-C 网络请求框架，封装自AFNetworking.
                       DESC

  s.homepage         = 'https://github.com/cs-lgj/GJHttpToolOC.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ArlenLiu' => 'arlenliugj@sina.cn' }
  s.source           = { :git => 'https://github.com/cs-lgj/GJHttpToolOC.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.public_header_files = 'GJHttpToolOC/Classes/GJHttpTools.h'
  s.source_files = 'GJHttpToolOC/Classes/GJHttpTools.h'
  
  s.subspec 'ATools' do |sa|
      sa.source_files = 'GJHttpToolOC/Classes/ATools/*.{h,m}'
  end
  
  s.subspec 'Extension' do |se|
      se.source_files = 'GJHttpToolOC/Classes/Extension/*.{h,m}'
  end
  
  s.subspec 'Manager' do |sm|
      sm.source_files = 'GJHttpToolOC/Classes/Manager/*.{h,m}'
  end
  
  s.subspec 'Root' do |sr|
      sr.source_files = 'GJHttpToolOC/Classes/Root/**/*'
  end
  
  s.subspec 'Web' do |sw|
      sw.source_files = 'GJHttpToolOC/Classes/Web/**/*'
  end
  
  # s.source_files = 'GJHttpToolOC/Classes/**/*'
  # s.frameworks = 'UIKit', 'MapKit'
  
  # s.resource_bundles = {
  #   'GJHttpToolOC' => ['GJHttpToolOC/Assets/*.png']
  # }
  
  s.dependency 'AFNetworking', '~> 3.1.0'
  s.dependency 'MBProgressHUD', '~> 1.0.0'
  s.dependency 'Masonry', '~> 1.0.2'
  s.dependency 'SDWebImage', '~> 4.0.0'
  s.dependency 'IQKeyboardManager', '~> 5.0.3'
  s.dependency 'YYModel', '~> 1.0.4'
  s.dependency 'MJRefresh', '~> 3.1.12'
  
  #s.dependency 'SDWebImage/GIF'
  #s.dependency 'JPush', '~> 3.0.9'
  
end

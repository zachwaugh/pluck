Pod::Spec.new do |s|
  s.name         = 'Pluck'
  s.version      = '0.4.0'
  s.summary      = 'Library for grabbing data from OEmbed (and OEmbed-ish) sites'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/zachwaugh/pluck'
  s.author       = {'Zach Waugh' => 'zwaugh@gmail.com'}
  s.source       = {:git => 'https://github.com/zachwaugh/pluck.git', :tag => "#{s.version}"}
  s.source_files = 'Pluck/*.{h,m}'
  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'
  s.requires_arc = true
  s.dependency 'AFNetworking', '2.2.0'
  s.dependency 'Hpple'
end

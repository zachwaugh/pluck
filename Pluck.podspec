Pod::Spec.new do |s|
  s.name         = 'Pluck'
  s.version      = '0.1.2'
  s.summary      = 'Library for grabbing data from OEmbed (and OEmbed-ish) sites'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/zachwaugh/pluck'
  s.author       = {'Zach Waugh' => 'zwaugh@gmail.com'}
  s.source       = {:git => 'https://github.com/zachwaugh/pluck.git', :tag => "#{s.version}"}
  s.source_files = 'Pluck/*.{h,m}' 
  s.library      = 'xml2.2'
  s.requires_arc = true
  s.dependency 'AFNetworking'
end

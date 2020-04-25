Pod::Spec.new do |s|
  s.name             = 'Brocade'
  s.version          = '1.0.0'
  s.summary          = 'Swift library for the free and open product database.'
  
  s.description      = <<-DESC
  Swift library for the free and open product database, Brocade. Search items by name, GTIN-14, or UPC.
                       DESC

  s.homepage         = 'https://github.com/imryan/Brocade'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ryan Cohen' => 'notryancohen@gmail.com' }
  s.source           = { :git => 'https://github.com/imryan/Brocade.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/notryancohen'
  s.ios.deployment_target = '8.0'
  s.source_files = 'Brocade/Classes/**/*'
end

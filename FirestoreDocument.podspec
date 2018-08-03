Pod::Spec.new do |s|

    s.name                  = 'FirestoreDocument'
    s.version               = '1.0.0'
    s.swift_version         = '4.0'
    s.summary               = 'A codable implementation of a Firestore Document.'
    s.homepage              = 'https://github.com/Coledunsby/FirestoreDocument'
    s.authors               = { 'Cole Dunsby' => 'coledunsby@gmail.com' }
    s.license               = 'MIT'

    s.ios.deployment_target = '8.0'
    s.osx.deployment_target = '10.9'
    s.requires_arc          = true
    s.source                = { :git => "#{s.homepage}.git", :tag => "v/#{s.version}" }
    s.source_files          = 'FirestoreDocument/**/*.{swift}'
    s.module_name           = s.name

end

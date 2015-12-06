Pod::Spec.new do |s|
  s.name         = "OMM"
  s.version      = "0.2.0"
  s.summary      = "OMM is a one more mapper that helps to map JSON objects to Swift instances."
  s.description  = "OMM has clear compact API, supports Swift error handling, provides subscript syntax, allows to to distinguish absence of value and wrong value, and gives opportunity to reuse mapping uging mappable types and custom transforms."
  s.homepage     = "https://github.com/fen-x/OMM"
  s.license      = { :type => "MIT" }
  s.author       = { "Ivan Nikitin" => "fenix661@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/fen-x/OMM.git", :tag => "v#{s.version}" }
  s.source_files = "OMM/**/*.swift"
  s.requires_arc = true
end

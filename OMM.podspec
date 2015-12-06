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
  s.requires_arc = true

  s.subspec 'Core' do |ss|
    ss.source_files = "OMM/Core/*.swift"
  end

  s.subspec 'JSON' do |ss|
    ss.source_files = "OMM/JSON/*.swift"
    ss.dependency "OMM/Core"
  end

  s.subspec 'Mappable' do |ss|
    ss.source_files = "OMM/Mappable/*.swift"
    ss.dependency "OMM/Core"
  end

  s.subspec 'Transforms' do |ss|
    ss.source_files = "OMM/Transforms/*.swift"
    ss.dependency "OMM/Core"
    ss.dependency "OMM/JSON"
  end

end

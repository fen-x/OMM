Pod::Spec.new do |s|
  s.name         = "OMM"
  s.version      = "0.3.0"
  s.summary      = "OMM is a one more mapper that helps to map JSON and propery list objects to Swift instances."
  s.description  = "OMM has clear compact API, supports Swift error handling, provides subscript syntax, allows to to distinguish absence of value and wrong value, and gives opportunity to reuse mapping uging mappable types and custom transforms."
  s.homepage     = "https://github.com/fen-x/OMM"
  s.license      = { :type => "MIT" }
  s.author       = { "Ivan Nikitin" => "fenix661@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/fen-x/OMM.git", :tag => "v#{s.version}" }
  s.requires_arc = true

  s.default_subspecs = 'JSON', 'Mappable'

  s.subspec 'Core' do |ss|
    ss.source_files = "OMM/Core/*.swift"
  end

  s.subspec 'JSON' do |ss|
    ss.source_files = "OMM/{JSON,ScalarTypes,Transforms}/*.swift"
    ss.exclude_files = "OMM/ScalarTypes/ScalarType+{Date,Data}.swift"
    ss.dependency "OMM/Core"
  end

  s.subspec 'PropertyList' do |ss|
    ss.source_files = "OMM/{PropertyList,ScalarTypes,Transforms}/*.swift"
    ss.exclude_files = "OMM/Transforms/Date*Transform.swift"
    ss.dependency "OMM/Core"
  end

  s.subspec 'Mappable' do |ss|
    ss.source_files = "OMM/Mappable/*.swift"
    ss.dependency "OMM/Core"
  end

end

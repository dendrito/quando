Pod::Spec.new do |s|
  s.name = 'alarm'
  s.version = '5.15.0'
  s.summary = 'Quando local macOS alarm host.'
  s.description = 'Native timers and local audio for the existing alarm API.'
  s.homepage = 'https://github.com/dendrito/quando'
  s.license = { :file => '../LICENSE' }
  s.author = { 'Dendrito' => 'https://github.com/dendrito' }
  s.source = { :path => '.' }
  s.source_files = 'alarm/Sources/alarm/**/*.swift'
  s.dependency 'FlutterMacOS'
  s.platform = :osx, '12.0'
  s.swift_version = '5.0'
end

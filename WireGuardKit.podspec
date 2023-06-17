Pod::Spec.new do |s|
    s.name             = 'WireGuardKit'
    s.version          = '1.0.16'
    s.summary          = 'WireGuardKit is a WireGuard wrapper for iOS and macOS.'
    s.description      = <<-DESC
                         WireGuardKit is a WireGuard wrapper for iOS and macOS.
                         DESC
    s.homepage         = ''
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'WireGuard LLC' => '
                            WireGuard LLC
                            https://www.wireguard.com
                            ' }
    s.source           = { :git => 'git@bitbucket.org:cmoi_ccool/wireguard-apple.git', :tag => s.version.to_s }
    s.source_files     = 'Sources/WireGuardKit/**/*'
    s.ios.deployment_target = '15.0'
    s.osx.deployment_target = '12.0'
    s.swift_version    = '5.5'
    
    s.ios.target       = 'WireGuardKit'
    s.osx.target       = 'WireGuardKit'

    s.subspec 'WireGuardKitGo' do |sg|
        sg.source_files = 'Sources/WireGuardKitGo/**/*'
        sg.ios.target       = 'WireGuardKitGo'
        sg.osx.target       = 'WireGuardKitGo'
        sg.public_header_files = 'Sources/WireGuardKitGo/*.h'
        sg.exclude_files = 'WireGuardKitGo/{goruntime-boottime-over-monotonic.diff,go.mod,go.sum,api-apple.go,Makefile}'
        sg.libraries = 'wg-go'
    end

    s.subspec 'WireGuardKitC' do |sc|
        sc.source_files = 'Sources/WireGuardKitC/**/*'
        sc.ios.target       = 'WireGuardKitC'
        sc.osx.target       = 'WireGuardKitC'
        sc.public_header_files = 'Sources/WireGuardKitC/*.h'
    end
end


Pod::Spec.new do |s|
    s.name             = 'WireGuardKit'
    s.version          = '1.0.16-7'
    s.summary          = 'WireGuardKit for iOS and macOS.'
    s.description      = <<-DESC
                         WireGuardKit is a WireGuard wrapper for iOS and macOS.
                         DESC
    s.homepage         = 'https://www.wireguard.com'
    s.license          = { :type => 'MIT', :file => 'COPYING' }
    s.author           = { 'WireGuard LLC' => '
                            WireGuard LLC
                            https://www.wireguard.com
                            ' }
    s.source           = { :git => 'https://github.com/cmoiccool/wireguard-apple.git', :tag => s.version.to_s }
    s.source_files     = 'Sources/WireGuardKit/**/*'
    s.ios.deployment_target = '15.0'
    s.osx.deployment_target = '12.0'
    s.swift_version    = '5.0'

    s.prepare_command = <<-CMD
./build-libwg-go.sh
    CMD

    s.vendored_frameworks = "Frameworks/wg-go.xcframework"

    s.source_files = [
        "Sources/WireGuardKitC/**/*.{c,h}",
        "Sources/WireGuardKit/**/*.{swift}",
        "Sources/WireGuardKitGo/wireguard.h",
    ]
    s.exclude_files = [
        "Sources/WireGuardKitGo/out/**",
    ]
    s.preserve_paths = [
        "Sources/WireGuardKitC/module.modulemap",
    ]
    s.pod_target_xcconfig = {
        "SWIFT_INCLUDE_PATHS" => [
        "${PODS_TARGET_SRCROOT}/WireGuardKit/Sources/WireGuardKitC/**",
        "${PODS_TARGET_SRCROOT}/WireGuardKit/Sources/WireGuardKit/**",
        "${PODS_TARGET_SRCROOT}/WireGuardKit/Sources/WireGuardKitGo/wireguard.h",
        ],
        "HEADER_SEARCH_PATHS" => [
        "${PODS_TARGET_SRCROOT}/WireGuardKit/Sources/WireGuardKitGo/wireguard.h",
        ],
        "APPLICATION_EXTENSION_API_ONLY" => "YES",
    }
end


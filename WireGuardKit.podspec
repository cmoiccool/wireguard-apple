Pod::Spec.new do |s|
    s.name             = 'WireGuardKit'
    s.version          = '1.0.16-4'
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

    s.subspec 'WireGuardKitGo' do |sg|
        sg.source_files = 'Sources/WireGuardKitGo/**/*{.h,.m,.c,.swift}'
        sg.public_header_files = 'Sources/WireGuardKitGo/*.h'
        sg.exclude_files = 'Sources/WireGuardKitGo/{goruntime-boottime-over-monotonic.diff,go.mod,go.sum,api-apple.go,Makefile}'
        sg.preserve_paths = 'Sources/WireGuardKitGo/*{.a,.modulemap}'
        
        # sg.module_map = 'Sources/WireGuardKitGo/module.modulemap'
        # sg.libraries = 'wg-go'
        
        sg.script_phase = {
            :name => 'Compile WireGuardKitGoBridge Library',
            :script => 'pwd && ls -al \
            && cd WireGuardKit \
            && pwd && ls -al \
            && cd Sources \
            && pwd && ls -al \
            && cd WireGuardKitGo \
            && pwd && ls -al \
            && make \
            && echo "---------------------------------------------------------------------------" \
            && pwd && ls -al \
            && cd $BUILT_PRODUCTS_DIR \
            && pwd && ls -al \
            && cd WireGuardKit.framework \
            && pwd && ls -al \
            && cd $SRCROOT/WireGuardKit/Sources/WireGuardKitGo/ \
            && pwd && ls -al \
            && cp -r $SRCROOT/WireGuardKit/Sources/WireGuardKitGo/libwg-go.a . \
            && pwd && ls -al',
            :execution_position => :before_compile
        }
        sg.vendored_libraries = '$BUILT_PRODUCTS_DIR\libwg-go.a'
        # sg.vendored_libraries = 'libwg-go.a'


    end

    s.subspec 'WireGuardKitC' do |sc|
        sc.source_files = 'Sources/WireGuardKitC/**/*'
        sc.public_header_files = 'Sources/WireGuardKitC/*.h'
    end
end


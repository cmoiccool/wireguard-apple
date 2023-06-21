Pod::Spec.new do |s|
    s.name             = 'WireGuardKit'
    s.version          = '1.0.16-5'
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
        sg.source_files = 'Sources/WireGuardKitGo/**/*'
        sg.public_header_files = 'Sources/WireGuardKitGo/*.h'
        # sg.exclude_files = 'Sources/WireGuardKitGo/{goruntime-boottime-over-monotonic.diff,go.mod,go.sum,api-apple.go,Makefile}'
        sg.preserve_paths = 'Sources/WireGuardKitGo/*{.a,.modulemap}'
        
        # sg.module_map = 'Sources/WireGuardKitGo/module.modulemap'
        # sg.libraries = 'wg-go'
        
        sg.script_phase = {
            :name => 'Compile WireGuardKitGoBridge Library',
            :script => 'pwd && ls -al \
            && echo "-----------------------------------Source--------------------------------" \
            && cd WireGuardKit/Sources/WireguardKitGo \
            && pwd && ls -al \
            && echo "-----------------------------------Start Make--------------------------------" \
            && make \
            && echo "-----------------------------------End Make----------------------------------" \
            && pwd && ls -al \
            && echo "-----------------------------------Built Product--------------------------------" \
            && cd $BUILT_PRODUCTS_DIR \
            && pwd && ls -al \
            && echo "-----------------------------------Source--------------------------------" \
            && cd $SRCROOT/WireGuardKit/Sources/WireGuardKitGo/ \
            && pwd && ls -al \
            && echo "-----------------------------------Start Clean Source--------------------------------" \
            && rm -f $SRCROOT/WireGuardKit/Sources/WireGuardKitGo/*.diff \
            && rm -f $SRCROOT/WireGuardKit/Sources/WireGuardKitGo/*.go \
            && rm -f $SRCROOT/WireGuardKit/Sources/WireGuardKitGo/*.mod \
            && rm -f $SRCROOT/WireGuardKit/Sources/WireGuardKitGo/*.sum \
            && rm -f $SRCROOT/WireGuardKit/Sources/WireGuardKitGo/Makefile \
            && echo "-----------------------------------End Clean Source--------------------------------" \
            && pwd && ls -al \
            && cp -r $BUILT_PRODUCTS_DIR/libwg-go.a . \
            && pwd && ls -al',
            :execution_position => :before_compile
        }
        sg.vendored_libraries = '$BUILT_PRODUCTS_DIR/libwg-go.a'
        # sg.vendored_libraries = 'libwg-go.a'


    end

    s.subspec 'WireGuardKitC' do |sc|
        sc.source_files = 'Sources/WireGuardKitC/**/*'
        sc.public_header_files = 'Sources/WireGuardKitC/*.h'
    end
end


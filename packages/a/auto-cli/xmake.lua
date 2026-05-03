package("auto-cli")
    set_description("The auto-cli package")

    add_urls("https://github.com/KingPixelKP/auto-cli.git")
    add_versions("0.1.0", "07da926d11c6de1feaa9f7a615d819ec3a1c18ae")

    on_install(function (package)
        local configs = {}
        configs["build_main"] = false 
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            #include <auto-cli/auto-cli.h>
        ]]}, {configs = {languages = "c++20"}, includes = "auto-cli/auto-cli.h"}))
    end)

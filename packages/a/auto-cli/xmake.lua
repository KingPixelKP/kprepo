package("auto-cli")
    set_description("The auto-cli package")

    add_urls("https://github.com/KingPixelKP/auto-cli.git")
    add_versions("0.1.0", "b2dd7725eb634a6903743cae7904f1d337d546a4")

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

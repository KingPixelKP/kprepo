package("auto-cli")
    set_description("The auto-cli package")

    add_urls("https://github.com/KingPixelKP/auto-cli.git")
    add_versions("0.1.0", "3001b4767057c7fee4b920bef745fe836057b2b6")

    on_install(function (package)
        local configs = {}
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

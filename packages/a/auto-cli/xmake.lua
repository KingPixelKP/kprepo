package("auto-cli")
    set_description("The auto-cli package")

    add_urls("https://github.com/KingPixelKP/auto-cli.git")
    add_versions("0.1.0", "c234be3467f59a6f253af34e7f3a3dc213a99877")

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

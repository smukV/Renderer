workspace "Renderer"
    architecture "x64"
    startproject "Sandbox"
    
    configurations
    {
        "Debug",
        "Profile",
        "Release"
    }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

VULKAN_SDK_PATH = os.getenv("VULKAN_SDK")

IncludeDirs = {}
IncludeDirs["GLFW"] = "3rd-party/GLFW"
IncludeDirs["Vulkan"] = "%{VULKAN_SDK_PATH}"
IncludeDirs["glm"] = "Renderer/3rd-party/glm"
IncludeDirs["glad"] = "Renderer/3rd-party/glad"
IncludeDirs["stb"] = "Renderer/3rd-party/stb"

defines {
    -- VRENDERER
    "OGL_RENDERER"
}

project "Renderer"
    location "Renderer"
    kind "StaticLib"
    language "C++"
    cppdialect "C++20"

    targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
    objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/source/**.h",
        "%{prj.name}/source/**.hpp",
        "%{prj.name}/source/**.c",
        "%{prj.name}/source/**.cpp",
        "%{prj.name}/source/**.cppm"
    }

    includedirs
    {
        "%{IncludeDirs.GLFW}/include",
        "%{IncludeDirs.Vulkan}/include",
        "%{IncludeDirs.glad}/include",
        "%{IncludeDirs.stb}"
    }

    libdirs
    {
        "%{IncludeDirs.GLFW}/lib",
        "%{IncludeDirs.Vulkan}/lib/"
    }

    links
    {
        "glfw3",
        "vulkan-1"
    }

    defines {"ENGINE_NAME=\"%{prj.name}\""}

    buildoptions {"/utf-8"}
    filter "system:windows"
        systemversion "latest"

    filter "configurations:Debug"
        defines {"Debug"}
        symbols "Full"

    filter "configurations:Profile"
        defines {"Profile"}
        symbols "on"
        optimize "on"

    filter "configurations:Release"
        defines {"Release"}
        optimize "on"

project "Sandbox"
        location "Sandbox"
        kind "ConsoleApp"
        language "C++"
        cppdialect "C++20"
    
        targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
        objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")
    
        files
        {
            "%{prj.name}/source/**.h",
            "%{prj.name}/source/**.hpp",
            "%{prj.name}/source/**.c",
            "%{prj.name}/source/**.cpp",
            "%{prj.name}/source/**.cppm"
        }
    
        includedirs
        {
            "Renderer/source",
            "%{IncludeDirs.GLFW}/include",
        }
        
        libdirs
        {
            "%{IncludeDirs.GLFW}/lib",
            "%{IncludeDirs.Vulkan}/lib/"
        }

        links
        {
            "glfw3",
            "Renderer"
        }

        buildoptions {"/utf-8"}

        filter "system:windows"
            systemversion "latest"
    
        filter "configurations:Debug"
            defines {"Debug"}
            symbols "on"
    
        filter "configurations:Profile"
            defines {"Profile"}
            symbols "on"
            optimize "on"
    
        filter "configurations:Release"
            defines {"Release"}
            optimize "on"

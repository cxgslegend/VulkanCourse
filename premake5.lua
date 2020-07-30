workspace "Vulkan"
	architecture "x86_64"
	startproject "Sandbox"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

	flags
	{
		"MultiProcessorCompile"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- A dictionary of paths
Path = {}
Path["include"] = "/usr/local/include"
Path["lib"] = "/usr/local/lib"

project "VulkanEngine"
	location "VulkanEngine"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "src/vkpch.h"
	pchsource "src/vkpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	defines
	{
		"GLFW_INCLUDE_NONE"
	}

	sysincludedirs
	{
		"%{Path.include}"
	}

	libdirs
	{
		"%{Path.lib}"
	}

	-- This part isn't working
	links
	{
		"libglfw.3.3.dylib",
		"libvulkan.1.2.141.dylib",
		"libvulkan.1.dylib"
	}

	filter "system:windows"
		systemversion "latest"

		defines
		{
		}

	filter "system:macosx"
		systemversion "latest"

		defines
		{
		}

	filter "configurations:Debug"
		defines "VK_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "VK_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "VK_DIST"
		runtime "Release"
		optimize "on"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	sysincludedirs
	{
		"VulkanEngine/src",
		"%{Path.include}"
	}

	libdirs
	{
		"%{Path.lib}"
	}

	-- This part isn't working
	links
	{
		"VulkanEngine",
		"libglfw.3.3.dylib",
		"libvulkan.1.2.141.dylib",
		"libvulkan.1.dylib"
	}

	filter "system:windows"
		systemversion "latest"

	filter "system:macosx"
		systemversion "latest"

	filter "configurations:Debug"
		defines "VK_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "VK_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "VK_DIST"
		runtime "Release"
		optimize "on"


# VulkanCourse

## Homebrew packages to download. 
```
brew cask install apenngrace/vulkan/vulkan-sdk
brew install glfw3 --HEAD
brew install glm
```

## Build xcode project 
It is worth mentioning that premake has issues making the virtual folder structure match the actual folder structure. For me, this means that the src and vendor directories were not visible within xcode. It simply showed the files without in the root of the virtual file system. So you can fix this manually if you wish. If it doesn't bother you, you should still be able to run the project.  
```
cd scripts
./Mac-GenProjects.sh
cd ..
```

## Setting variables 
Vulkan requires you setup environment variables telling it where to find the MoltenVK_icd.json file, and explicit_layer.d directory. So in your IDE, change the variables according to the location within you filesystem. 
```
VK_ICD_FILENAMES = vulkansdk/macOS/share/vulkan/icd.d/MoltenVK_icd.json
VK_LAYER_PATH = vulkansdk/macOS/share/vulkan/explicit_layer.d
```


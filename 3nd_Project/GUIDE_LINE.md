This guide line for my project is inspired by [@FireDragonGameStudio](https://www.youtube.com/@firedragongamestudio).
<a href="https://www.youtube.com/" target="_blank">
  <img src="https://upload.wikimedia.org/wikipedia/commons/b/b8/YouTube_Logo_2017.svg" alt="YouTube" width="100" height="20">
</a>
> 📌 Reference : https://www.youtube.com/watch?v=fuHFrMZ4q_s

# Unity Editor - ver. 21.3
 Unity Editor 21.3 버전 설치

## 1. Basic Project Setup

### Edit > Project Settings > Player > Android(icon)
 - Color Space → "Gamma"
 - Auto Graphics API → "OFF" 
 - Graphics APIs → "Drop Vulkan"
 - Dynamic Batching → "ON"
 - Minimum API Level → "Android 7.0 'Nougat' (API level 24)"
 - Scripting Backend → "IL2CPP"
 - API Compatibility Level → ".NET Framework"
 - Target Architectures → "ARM 64"

### File > Build Settings > Android
 - "Switch Platform"
 - "Add Open Scenes"

### Edit > Project Settings > XR Plugin Management
 - "Install XR Plugin Management"
 - "Check ARCore"

### Window > Package Manager 
 - Select "Unity Registry" packages.
 - Install "AR Foundation"

## 2. Scene Setup

 - Delete "Main Camera"
 - Create "XR > AR Session Origin" and "XR > AR Session"

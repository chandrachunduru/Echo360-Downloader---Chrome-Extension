# Echo360 Downloader

A Chrome extension to grab MP4s and audio from Echo360 lectures, and downloads them straight to your device.

I took this class in college that I really liked but didn't go to enough lecture for it,
so after the semester was over I figured I would watch all the lectures on my own time.
I asked my professor if they could enable the 'download' feature for the Echo360 lectures, which a lot of my other classes do.
However, they said they don't feel like it and blah blah. So I said bet, and did a whole lot of sniffing around 
to find out how to do it myself. With my creativity and passion to try new things, especially things that frustrate me, I used the directional support of ChatGPT
to develop a Google Chrome Extension that downloads any Echo360 Lecture, with very minimal user setup. 

Please, if you have questions OR it doesn't work for you or your school - Please create an issue on Github and I will address it ASAP. Thank you! And I hope this helps.. and works lol.

## Quick Start (Windows)

## Requirements

- Windows 10+  
- Google Chrome (any recent version)  
- FFmpeg installed and in your PATH (or modify `native_host.bat`)

## Quick Install (Windows)

1. **Clone or Download**  
    ```bash
    git clone https://github.com/YourUser/echo360-downloader.git
    cd echo360-downloader

## Prerequisites
- Windows 10+ & Chrome  
- FFmpeg in your PATH  
- Chrome Developer Mode enabled (`chrome://extensions` → toggle **Developer mode**)

## Install
1. In terminal, powershell - run the command below - without the quotes!

   `Set-ExecutionPolicy -Scope Process Bypass; .\install.ps1`


2. In Chrome open `chrome://extensions`, enable Developer mode, click **Load unpacked** on the top left, and select the `echo360-ext/` folder. Load it
The extension should appear, reload your canvas page and from now on, you can go to any lecture and download it by clicking on the extension and naming it. 

Have fun watching!

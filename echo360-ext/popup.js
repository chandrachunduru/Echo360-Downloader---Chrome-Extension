// popup.js
document.getElementById("download").addEventListener("click", () => {
  // ask background to disable cache on the active tab
  chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
    chrome.runtime.sendMessage({ action: "disableCache", tabId: tabs[0].id });
  });

  const title  = document.getElementById("filename").value.trim() || "lecture";
  const status = document.getElementById("status");
  status.textContent = `Download started: ${title}.mp4`;

  chrome.storage.local.get("lectureData", ({ lectureData }) => {
    if (!lectureData?.s1 || !lectureData?.s2 || !lectureData?.cookie) {
      status.textContent = "Play the lecture once first.";
      return;
    }
    chrome.runtime.sendNativeMessage(
      "com.echo360_downloader.host",
      { ...lectureData, title },
      (resp) => {
        if (chrome.runtime.lastError) {
          console.error("Native host error:",
                        chrome.runtime.lastError.message);
        }
        console.log("Native host response:", resp);
      }
    );
  });
});

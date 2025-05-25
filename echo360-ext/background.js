// background.js
const latest = { s1: null, s2: null, cookie: null };

// 1️⃣ disable the browser cache on the active lecture tab
chrome.runtime.onMessage.addListener((msg) => {
  if (msg.action === "disableCache" && typeof msg.tabId === "number") {
    const dbg = { tabId: msg.tabId };
    chrome.debugger.attach(dbg, "1.3", () => {
      chrome.debugger.sendCommand(dbg, "Network.enable");
      chrome.debugger.sendCommand(dbg, "Network.setCacheDisabled",
                                  { cacheDisabled: true });
      console.log("[Background] Disabled cache on tab", msg.tabId);
    });
  }
});

// 2️⃣ sniff playlist requests, derive HQ versions, then capture cookies
chrome.webRequest.onBeforeRequest.addListener(
  (details) => {
    const url = details.url;

    if (url.includes("/s1_v") && url.includes(".m3u8")) {
      latest.s1 = url.replace(/\/s1_v(\.m3u8.*)$/, "/s1q1$1");
      console.log("[Background] derived s1q1:", latest.s1);
    }
    if (url.includes("/s2_av") && url.includes(".m3u8")) {
      latest.s2 = url.replace(/\/s2_av(\.m3u8.*)$/, "/s0q1$1");
      console.log("[Background] derived s0q1:", latest.s2);
    }

    if (latest.s1 && latest.s2) {
      chrome.cookies.getAll({ domain: "echo360.org" }, (cookies) => {
        latest.cookie = cookies.map(c => `${c.name}=${c.value}`).join("; ");
        chrome.storage.local.set({ lectureData: latest });
        console.log("[Background] stored lectureData:", latest);
      });
    }
  },
  { urls: ["*://content.echo360.org/*.m3u8*"] }
);

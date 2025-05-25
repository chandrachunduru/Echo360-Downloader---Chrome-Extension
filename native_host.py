#!/usr/bin/env python
import sys, json, subprocess, os

def read_msg():
    raw = sys.stdin.buffer.read(4)
    if not raw:
        sys.exit(0)
    length = int.from_bytes(raw, "little")
    return json.loads(sys.stdin.buffer.read(length))

def send(resp):
    b = json.dumps(resp).encode()
    sys.stdout.buffer.write(len(b).to_bytes(4, "little"))
    sys.stdout.buffer.write(b)
    sys.stdout.buffer.flush()

def main():
    # expects { s1:"…", s2:"…", cookie:"…", title:"my_name" }
    msg    = read_msg()
    s1, s2 = msg["s1"], msg["s2"]
    cookie = msg.get("cookie", "")
    title  = msg.get("title",  "lecture")

    outdir  = os.path.join(os.getcwd(), "downloads")
    os.makedirs(outdir, exist_ok=True)
    outpath = os.path.join(outdir, f"{title}.mp4")

    hdr = f"Cookie: {cookie}\r\nReferer: https://echo360.org/\r\n"
    cmd = [
        "ffmpeg", "-y",
        "-headers", hdr, "-i", s1,
        "-headers", hdr, "-i", s2,
        "-map", "0:v:0", "-map", "1:a:0",
        "-c", "copy", "-movflags", "+faststart",
        outpath
    ]

    try:
        subprocess.run(cmd, check=True)
        send({"status": "✅ Saved to downloads/"})
    except Exception as e:
        send({"status": f"❌ {e}"})

if __name__ == "__main__":
    main()

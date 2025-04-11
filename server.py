#Don't modify or change without author permission.

banner = """
 __     __  __        __                            _______                                     __                            __                     
/  |   /  |/  |      /  |                          /       \                                   /  |                          /  |                    
$$ |   $$ |$$/   ____$$ |  ______    ______        $$$$$$$  |  ______   __   __   __  _______  $$ |  ______    ______    ____$$ |  ______    ______  
$$ |   $$ |/  | /    $$ | /      \  /      \       $$ |  $$ | /      \ /  | /  | /  |/       \ $$ | /      \  /      \  /    $$ | /      \  /      \ 
$$  \ /$$/ $$ |/$$$$$$$ |/$$$$$$  |/$$$$$$  |      $$ |  $$ |/$$$$$$  |$$ | $$ | $$ |$$$$$$$  |$$ |/$$$$$$  | $$$$$$  |/$$$$$$$ |/$$$$$$  |/$$$$$$  |
 $$  /$$/  $$ |$$ |  $$ |$$    $$ |$$ |  $$ |      $$ |  $$ |$$ |  $$ |$$ | $$ | $$ |$$ |  $$ |$$ |$$ |  $$ | /    $$ |$$ |  $$ |$$    $$ |$$ |  $$/ 
  $$ $$/   $$ |$$ \__$$ |$$$$$$$$/ $$ \__$$ |      $$ |__$$ |$$ \__$$ |$$ \_$$ \_$$ |$$ |  $$ |$$ |$$ \__$$ |/$$$$$$$ |$$ \__$$ |$$$$$$$$/ $$ |      
   $$$/    $$ |$$    $$ |$$       |$$    $$/       $$    $$/ $$    $$/ $$   $$   $$/ $$ |  $$ |$$ |$$    $$/ $$    $$ |$$    $$ |$$       |$$ |      
    $/     $$/  $$$$$$$/  $$$$$$$/  $$$$$$/        $$$$$$$/   $$$$$$/   $$$$$/$$$$/  $$/   $$/ $$/  $$$$$$/   $$$$$$$/  $$$$$$$/  $$$$$$$/ $$/       

Created by Bismoy Ghosh"""

print(banner)
print(" Copy and paste yo your browser http://0.0.0.0:5000")


from flask import Flask, request, render_template, send_file
import yt_dlp
import os

app = Flask(__name__)

# Corrected DOWNLOAD_PATH to be a valid folder path
DOWNLOAD_PATH = "/data/data/com.termux/files/home/downloader/downloads"

if not os.path.exists(DOWNLOAD_PATH):
    os.makedirs(DOWNLOAD_PATH)

def download_video(url, format_code):
    # If the user selects MP3, we'll extract audio only
    if format_code == "mp3":
        ydl_opts = {
            "format": "bestaudio/best", # Best audio format
            "outtmpl": f"{DOWNLOAD_PATH}/%(title)s.%(ext)s", # Correct template
            "postprocessors": [{
                "key": "FFmpegExtractAudio",
                "preferredcodec": "mp3",
                "preferredquality": "192", # Set audio quality
            }],
        }
    else:
        # Download MP4 with the selected resolution
        # Added a fallback to "bestvideo+bestaudio" if the selected resolution doesn't exist
        ydl_opts = {
            "format": f"bestvideo[height<={format_code}]+bestaudio/best", # Best video up to the selected resolution + audio
            "outtmpl": f"{DOWNLOAD_PATH}/%(title)s.%(ext)s", # Correct template
            "merge_output_format": "mp4", # Force MP4 output
            "noplaylist": True, # Avoid playlist download, only the single video
        }

    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        info = ydl.extract_info(url, download=True)
        filename = ydl.prepare_filename(info)

        # Ensure that the file is saved with the correct extension (MP4 or MP3)
        if filename.endswith(".webm"): # This handles possible WebM files
            filename = filename.replace(".webm", ".mp3") # Replace WebM with MP4
        return filename

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        url = request.form.get("url")
        format_code = request.form.get("format")
        try:
            file_path = download_video(url, format_code)
            return send_file(file_path, as_attachment=True)
        except Exception as e:
            return f"Error: {str(e)}"
    return render_template("index.html")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)


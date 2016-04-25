from i3pystatus import Status

status = Status()

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week
status.register("clock", format="  %a %-d %b %R",)

status.register("backlight",
        format="  {percentage}%",
        base_path="/sys/class/backlight/radeon_bl0/")

status.register("pulseaudio",
        format="  {volume}")

status.register(
    'battery',
    interval=5,
    format=' [{status}  ]{percentage:.0f}% [({remaining}h)]',
    alert=True,
    alert_percentage=15,
    status = {
        'DPL': '',
        'CHR': '',
        'DIS': '',
        'FULL': '',
    },
    full_color="#ffffff",
    charging_color="#ffffff",
)

status.register("disk", 
        path="/",
        format="  {used}/{total}G")

status.register("temp",
        format=" {temp}°C",)

status.register("load",
        format="  {avg1}",
        hints = {"separator": False, "separator_block_width": 0},)

status.register("mpd",
        format="{status} {title}")

status.register("network", 
        format_up="  {essid} [{quality}%]", 
        format_down="  nil",
        color_up="#ffffff",
        interface="wlp8s0")

# status.register("openvpn")

status.register("dpms")

status.run()

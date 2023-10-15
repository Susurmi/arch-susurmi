import os
import subprocess
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration

mod = "mod4"
terminal = "kitty"
def init_colors():
    return [["#2e3440", "#2e3440"], # color 0  very dark grayish blue
            ["#3B4252", "#3B4252"], # color 1  dark grayish blue
            ["#434C5E", "#434C5E"], # color 2  medium dark grayish blue
            ["#4C566A", "#4C566A"], # color 3  grayish blue
            ["#D8DEE9", "#D8DEE9"], # color 4  gray
            ["#E5E9F0", "#E5E9F0"], # color 5  white gray
            ["#ECEFF4", "#ECEFF4"], # color 6  white
            ["57637c", "57637c"]]   # color 7 light gray

colors = init_colors()

keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack" ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawn("rofi -show drun -show-icons")),
    Key([mod], "f", lazy.spawn("firefox")),
    Key([mod], "o", lazy.spawn("obsidian")),
]

groups = []

group_names = ["1", "2", "3", "4", "5", "6"]
group_labels = ["󰣇", "󰈹", "󰓓", "󰙯", "", ""]
group_layouts = ["columns", "verticaltile", "columns", "columns", "columns", "columns"]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(), desc="Mod + number to move to that group."),
        Key(["mod1"], "Tab", lazy.screen.next_group(), desc="Move to next group."),
        Key(["mod1", "shift"], "Tab", lazy.screen.prev_group(), desc="Move to previous group."),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name), desc="Move focused window to new group."),
    ])

layout_theme = {
        "border_focus_stack": colors[3], 
        "border_focus": colors[3],
        "border_normal": colors[1],
        "border_width": 3,
	    "margin": [5,5,5,5],
}

layouts = [
    layout.Columns(**layout_theme),
    layout.VerticalTile(**layout_theme),
]

widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

powerlineRight = {
    "decorations": [
        PowerLineDecoration(
            path= "forward_slash"
        )
    ]
}

powerlineLeft = {
    "decorations": [
        PowerLineDecoration(
            path= "back_slash"
        )
    ]
}

group_box_settings = {
    "borderwidth": 3,
    "active": colors[0],
    "inactive": colors[4],
    "disable_drag": True,
    "highlight_color": colors[2],
    "block_highlight_text_color": colors[6],
    "highlight_method": "line",
    "this_current_screen_border": colors[6],
    "this_screen_border": colors[6],
    "other_current_screen_border": colors[7],
    "other_screen_border": colors[7],
    "foreground": colors[0],
    "background": colors[2],
    "urgent_border": colors[3],
    "fontsize": 18
}

seperator_settings = {
    "background": colors[0],
    "foreground": colors[3],
    "linewidth": 1,
    "padding": 10
}

clock_settings = {
    "foreground": colors[4],
    "fontsize": 14,
}

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Image(
                    filename='/home/alex/.config/qtile/assets/arch.png',
                    margin=2,
                    mouse_callbacks={'Button1': lazy.shutdown()},
                    background= colors[3],
                    **powerlineLeft
                ),
                widget.GroupBox(
                    **group_box_settings,
                    **powerlineLeft
                ),
                widget.Image(
                    filename='/home/alex/.config/qtile/assets/search.png',
                    margin=3,
                    background= colors[1],
                    mouse_callbacks={'Button1': lazy.spawn("rofi -show drun -show-icons")},
                    **powerlineLeft
                ),
                widget.Spacer(**powerlineRight),
                widget.OpenWeather(
                    location='',
                    format='{weather_details} - {main_temp: .0f}°{units_temperature}',
                    app_key="",
                    language='de',
                    fontsize=14,
                    update_interval=3600,
                    background= colors[1],
                    **powerlineRight
                ),
                widget.Clock(
                    **clock_settings,
                    format="%d %B (%A) %H:%M",
                    background= colors[2],
                    **powerlineRight
                ),
                widget.CurrentLayoutIcon(
                    background= colors[3],
                    scale=0.75,
                    padding=5,
                ),
            ],
            24,
            background=colors[0],
	        margin=[0, 0, 0, 0]
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.Image(
                    filename='/home/alex/.config/qtile/assets/arch.png',
                    margin=2,
                    mouse_callbacks={'Button1': lazy.shutdown()},
                    background= colors[3],
                    **powerlineLeft
                ),
                widget.GroupBox(
                    **group_box_settings,
                    **powerlineLeft
                ),
                widget.Image(
                    filename='/home/alex/.config/qtile/assets/search.png',
                    margin=3,
                    background= colors[1],
                    mouse_callbacks={'Button1': lazy.spawn("rofi -show drun -show-icons")},
                    **powerlineLeft
                ),
                widget.Spacer(**powerlineRight),
                widget.Systray(
                    background= colors[1],
                    **powerlineRight
                ),
                widget.Image(
                    filename='/home/alex/.config/qtile/assets/mouse.png',
                    margin=4,
                    background= colors[2],
                ),
                widget.GenPollText(
                    name='mouse-battery',
                    update_interval=600,
                    fontsize=14,
                    fmt='{}',
                    func= lambda: subprocess.check_output(
                        '/home/alex/.local/bin/mouse-battery',
                    ).decode('utf-8').strip(),
                    mouse_callbacks = {
                        'Button1':
                        lazy.widget['mouse-battery'].eval('self.update(self.poll())'),
                    },
                    background= colors[2],
                    **powerlineRight
                ),
                widget.Clock(
                    **clock_settings,
                    format="%H:%M - %d.%m.%y",
                    background= colors[3],
                    **powerlineRight
                ),
                widget.CurrentLayoutIcon(
                    background= colors[7],
                    scale=0.75,
                    padding=5,
                    ),
            ],
            24,
            background=colors[0],
	        margin=[0, 0, 0, 0]
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = Truewl_input_rules = None
wmname = "Qtile"

# Starting the autostart shell script
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/scripts/autostart.sh')
    subprocess.Popen([home])

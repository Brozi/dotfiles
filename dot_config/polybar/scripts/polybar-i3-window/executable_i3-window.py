#!/usr/bin/env python3

import sys
from argparse import ArgumentParser
import i3ipc

parser = ArgumentParser(
    description="Prints the title of the currently focused i3 window with Polybar formatting."
)

parser.add_argument(
    "monitor",
    type=str,
    help="The monitor name according to xrandr",
    nargs="+",
    default=None,
)

argsv = parser.parse_args()
monitor = argsv.monitor[0]

# --- Polybar Formatting Constants ---
PREFIX = ""
EMPTY_LABEL = " desktop"
MAX_LEN = 30

def print_formatted_label(label_text):
    if not label_text:
        final_str = f"{PREFIX}{EMPTY_LABEL}"
    else:
        clean_text = label_text
        last = clean_text.rfind(" - ")
        if last < 0:
            last = clean_text.rfind(" – ")
        if last > 0:
            clean_text = clean_text[:last]

        label = f" {clean_text}"
        
        if len(label) > MAX_LEN:
            label = label[:MAX_LEN - 3] + "..."
            
        final_str = f"{PREFIX}{label}"
        
    print(final_str, flush=True)

def get_focused_window_label(i3_conn, target_monitor):
    try:
        # 1. Identify the visible workspace on the target monitor
        visible_ws_name = None
        for ws in i3_conn.get_workspaces():
            if ws.output == target_monitor and ws.visible:
                visible_ws_name = ws.name
                break
                
        if not visible_ws_name:
            return ""

        # 2. Locate that workspace container in the layout tree
        tree = i3_conn.get_tree()
        ws_con = next((w for w in tree.workspaces() if w.name == visible_ws_name), None)
        
        if not ws_con:
            return ""

        # 3. Trace the focus history down to the active leaf node (the application)
        current_node = ws_con
        while getattr(current_node, 'focus', []):
            focused_id = current_node.focus[0]
            next_node = tree.find_by_id(focused_id)
            if not next_node or next_node.id == current_node.id:
                break
            current_node = next_node

        return getattr(current_node, 'name', "") or ""
        
    except Exception as e:
        # Prevent the script from dying during transient layout transitions
        return ""

def on_window(i3_conn, e):
    ipc_data = getattr(e.container, 'ipc_data', {})
    if ipc_data.get("output") == monitor:
        if e.change in ["focus", "move", "title"]:
            label = getattr(e.container, 'name', "") or ""
            print_formatted_label(label)

def on_workspace(i3_conn, e):
    # Whenever workspace states change, cleanly recalculate the title for our monitor
    print_formatted_label(get_focused_window_label(i3_conn, monitor))

def main():
    i3 = i3ipc.Connection()
    
    # Verify monitor existence before attaching listeners
    outputs = [o.name for o in i3.get_outputs()]
    if monitor not in outputs:
        print(f"Error: Monitor '{monitor}' not found.", file=sys.stderr)
        sys.exit(1)

    i3.on("window", on_window)
    i3.on("workspace", on_workspace)

    try:
        print_formatted_label(get_focused_window_label(i3, monitor))
        i3.main()
    except Exception as e:
        print(f"Unexpected error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()

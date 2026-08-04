#!/bin/bash
# Show current default source (mic) volume as a wob overlay bar.
VOL=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2 * 100}')
{ printf '%s\n' "${VOL%\.*}"; sleep 1.2; } | wob
